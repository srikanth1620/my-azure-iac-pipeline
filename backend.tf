# Use your existing Resource Group (do not create new one)
data "azurerm_resource_group" "tfstate" {
  name = "tfstate-rg"        # Change only if your RG name is different
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate1620sri"     # Must be globally unique + lowercase
  resource_group_name      = data.azurerm_resource_group.tfstate.name
  location                 = data.azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # This is often required by company policies
  allow_nested_items_to_be_public = false

  # Enable encryption (most policies require this)
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}