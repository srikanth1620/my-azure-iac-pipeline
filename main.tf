    resource "azurerm_resource_group" "second_rg" {
       name     = var.second_rg_name
       location = var.location
     }

     # Key Vault for CMK
     resource "azurerm_key_vault" "cmk_vault" {
       name                        = var.key_vault_name
       resource_group_name         = azurerm_resource_group.second_rg.name
       location                    = azurerm_resource_group.second_rg.location
       sku_name                    = "standard"
       tenant_id                   = var.tenant_id
       enable_rbac_authorization   = true
       purge_protection_enabled    = false
     }

     # Key Vault Key for CMK
     resource "azurerm_key_vault_key" "cmk_key" {
       name         = "cmk-key"
       key_vault_id = azurerm_key_vault.cmk_vault.id
       key_type     = "RSA"
       key_size     = 2048
       key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
     }

     # Storage account with CMK encryption
     resource "azurerm_storage_account" "cmk_storage" {
       name                     = var.cmk_storage_name
       resource_group_name      = azurerm_resource_group.second_rg.name
       location                 = azurerm_resource_group.second_rg.location
       account_tier             = "Standard"
       account_replication_type = "LRS"
       identity {
         type = "SystemAssigned"
       }
       customer_managed_key {
         key_vault_id = azurerm_key_vault.cmk_vault.id
         key_name     = azurerm_key_vault_key.cmk_key.name
       }
       depends_on = [azurerm_key_vault.cmk_vault, azurerm_key_vault_key.cmk_key]
     }

     resource "azurerm_storage_container" "cmk_container" {
       name                  = var.cmk_container_name
       storage_account_name  = azurerm_storage_account.cmk_storage.name
       container_access_type = "private"
     }

     resource "azurerm_role_assignment" "cmk_storage_keyvault_access" {
       scope                = azurerm_key_vault.cmk_vault.id
       role_definition_name = "Key Vault Crypto Service Encryption User"
       principal_id         = azurerm_storage_account.cmk_storage.identity[0].principal_id
     }