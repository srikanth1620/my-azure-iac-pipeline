  resource "azurerm_resource_group" "second_rg" {
    name     = var.second_rg_name
    location = var.location
  }

  # New test storage account (simulate non-compliance with a tag)
  resource "azurerm_storage_account" "policy_test_storage" {
    name                     = var.policy_test_storage_name
    resource_group_name      = azurerm_resource_group.second_rg.name
    location                 = azurerm_resource_group.second_rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      EncryptionTest = "NonCompliant"  # Tag to trigger policy denial
    }
  }

  resource "azurerm_storage_container" "policy_test_container" {
    name                  = var.policy_test_container_name
    storage_account_name  = azurerm_storage_account.policy_test_storage.name
    container_access_type = "private"
  }