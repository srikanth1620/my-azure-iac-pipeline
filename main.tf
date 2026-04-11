   # main.tf - Fixed to use existing resources

# Use existing Resource Group
data "azurerm_resource_group" "second_rg" {
  name = var.second_rg_name
}

# Use existing User Assigned Identity
data "azurerm_user_assigned_identity" "cmk_identity" {
  name                = var.cmk_identity_name
  resource_group_name = data.azurerm_resource_group.second_rg.name
}

# Use existing Key Vault
data "azurerm_key_vault" "cmk_vault" {
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.second_rg.name
}

# Key Vault Key (this can stay as resource if you want to manage it)
resource "azurerm_key_vault_key" "cmk_key" {
  name         = "cmk-key"
  key_vault_id = data.azurerm_key_vault.cmk_vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]

  depends_on = [azurerm_role_assignment.service_principal_keyvault_access]
}

# Storage account with CMK (assuming it already exists)
data "azurerm_storage_account" "cmk_storage" {
  name                = var.cmk_storage_name
  resource_group_name = data.azurerm_resource_group.second_rg.name
}

resource "azurerm_storage_container" "cmk_container" {
  name                  = var.cmk_container_name
  storage_account_id    = data.azurerm_storage_account.cmk_storage.id
  container_access_type = "private"
}

# Role assignments (these usually stay as resources)
resource "azurerm_role_assignment" "cmk_storage_keyvault_access" {
  scope                = data.azurerm_key_vault.cmk_vault.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = data.azurerm_user_assigned_identity.cmk_identity.principal_id
}

resource "azurerm_role_assignment" "service_principal_keyvault_access" {
  scope                = data.azurerm_key_vault.cmk_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.service_principal_id
}