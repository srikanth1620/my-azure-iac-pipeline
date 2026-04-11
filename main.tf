   # main.tf - Fixed version

# Use existing Resource Group
data "azurerm_resource_group" "second_rg" {
  name = var.second_rg_name
}

# User-assigned managed identity
resource "azurerm_user_assigned_identity" "cmk_identity" {
  name                = var.cmk_identity_name
  resource_group_name = data.azurerm_resource_group.second_rg.name
  location            = data.azurerm_resource_group.second_rg.location
}

# Key Vault
resource "azurerm_key_vault" "cmk_vault" {
  name                        = var.key_vault_name
  resource_group_name         = data.azurerm_resource_group.second_rg.name
  location                    = data.azurerm_resource_group.second_rg.location
  sku_name                    = "standard"
  tenant_id                   = var.tenant_id
  enable_rbac_authorization   = true
  purge_protection_enabled    = true
}

# Key Vault Key
resource "azurerm_key_vault_key" "cmk_key" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.cmk_vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]

  depends_on = [azurerm_role_assignment.service_principal_keyvault_access]
}

# CMK Storage Account - This one needs to be created
resource "azurerm_storage_account" "cmk_storage" {
  name                     = var.cmk_storage_name
  resource_group_name      = data.azurerm_resource_group.second_rg.name
  location                 = data.azurerm_resource_group.second_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.cmk_identity.id]
  }

  customer_managed_key {
    key_vault_key_id          = azurerm_key_vault_key.cmk_key.id
    user_assigned_identity_id = azurerm_user_assigned_identity.cmk_identity.id
  }

  depends_on = [azurerm_key_vault.cmk_vault, azurerm_key_vault_key.cmk_key]
}

resource "azurerm_storage_container" "cmk_container" {
  name                  = var.cmk_container_name
  storage_account_id    = azurerm_storage_account.cmk_storage.id
  container_access_type = "private"
}

# Role Assignments
resource "azurerm_role_assignment" "cmk_storage_keyvault_access" {
  scope                = azurerm_key_vault.cmk_vault.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.cmk_identity.principal_id
}

resource "azurerm_role_assignment" "service_principal_keyvault_access" {
  scope                = azurerm_key_vault.cmk_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.service_principal_id
}