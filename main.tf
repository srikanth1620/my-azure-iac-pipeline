     resource "azurerm_resource_group" "second_rg" {
       name     = var.second_rg_name
       location = var.location
     }

     # Existing storage account (Microsoft-managed keys, compliant by default)
     resource "azurerm_storage_account" "second_storage" {
       name                     = var.second_storage_name
       resource_group_name      = azurerm_resource_group.second_rg.name
       location                 = azurerm_resource_group.second_rg.location
       account_tier             = "Standard"
       account_replication_type = "LRS"
     }

     resource "azurerm_storage_container" "second_container" {
       name                  = var.second_container_name
       storage_account_name  = azurerm_storage_account.second_storage.name
       container_access_type = "private"
     }

     # First test storage account (simulate non-compliance with a tag)
     resource "azurerm_storage_account" "test_storage" {
       name                     = var.test_storage_name
       resource_group_name      = azurerm_resource_group.second_rg.name
       location                 = azurerm_resource_group.second_rg.location
       account_tier             = "Standard"
       account_replication_type = "LRS"
       tags = {
         EncryptionTest = "NonCompliant"
       }
     }

     resource "azurerm_storage_container" "test_container" {
       name                  = var.test_container_name
       storage_account_name  = azurerm_storage_account.test_storage.name
       container_access_type = "private"
     }

     # Second test storage account (simulate non-compliance with a tag)
     resource "azurerm_storage_account" "new_test_storage" {
       name                     = var.new_test_storage_name
       resource_group_name      = azurerm_resource_group.second_rg.name
       location                 = azurerm_resource_group.second_rg.location
       account_tier             = "Standard"
       account_replication_type = "LRS"
       tags = {
         EncryptionTest = "NonCompliant"
       }
     }

     resource "azurerm_storage_container" "new_test_container" {
       name                  = var.new_test_container_name
       storage_account_name  = azurerm_storage_account.new_test_storage.name
       container_access_type = "private"
     }

     # Third test storage account (simulate non-compliance with a tag)
     resource "azurerm_storage_account" "extra_test_storage" {
       name                     = var.extra_test_storage_name
       resource_group_name      = azurerm_resource_group.second_rg.name
       location                 = azurerm_resource_group.second_rg.location
       account_tier             = "Standard"
       account_replication_type = "LRS"
       tags = {
         EncryptionTest = "NonCompliant"
       }
     }

     resource "azurerm_storage_container" "extra_test_container" {
       name                  = var.extra_test_container_name
       storage_account_name  = azurerm_storage_account.extra_test_storage.name
       container_access_type = "private"
     }