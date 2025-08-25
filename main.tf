
     resource "azurerm_resource_group" "second_rg" {
       name     = var.second_rg_name
       location = var.location
     }

     # Existing storage account (Microsoft-managed keys)
     resource "azurerm_storage_account" "second_storage" {
       name                          = var.second_storage_name
       resource_group_name           = azurerm_resource_group.second_rg.name
       location                      = azurerm_resource_group.second_rg.location
       account_tier                  = "Standard"
       account_replication_type      = "GRS"  # Updated for resilience
       min_tls_version               = "TLS1_2"  # For security
       allow_blob_public_access      = false  # For security
       enable_https_traffic_only     = true  # For security
       is_hns_enabled                = false
       blob_properties {
         delete_retention_policy {
           days = 7  # Enable soft delete
         }
       }
     }

     resource "azurerm_storage_container" "second_container" {
       name                  = var.second_container_name
       storage_account_name  = azurerm_storage_account.second_storage.name
       container_access_type = "private"
     }

     # Test storage account with no encryption (should be denied by policy)
     resource "azurerm_storage_account" "test_storage" {
       name                          = var.test_storage_name
       resource_group_name           = azurerm_resource_group.second_rg.name
       location                      = azurerm_resource_group.second_rg.location
       account_tier                  = "Standard"
       account_replication_type      = "GRS"
       min_tls_version               = "TLS1_2"
       allow_blob_public_access      = false
       enable_https_traffic_only     = true
       is_hns_enabled                = false
       encryption {
         key_source = "None"  # Invalid value to simulate no encryption
       }
       blob_properties {
         delete_retention_policy {
           days = 7
         }
       }
     }

     resource "azurerm_storage_container" "test_container" {
       name                  = var.test_container_name
       storage_account_name  = azurerm_storage_account.test_storage.name
       container_access_type = "private"
     }
     