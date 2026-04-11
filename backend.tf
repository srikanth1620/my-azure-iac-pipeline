# backend.tf - Using existing storage account (no creation)

data "azurerm_resource_group" "tfstate" {
  name = "tfstate-rg"
}

# Read the existing storage account (do not create it again)
data "azurerm_storage_account" "tfstate" {
  name                = "tfstate1620sri"
  resource_group_name = "tfstate-rg"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_id    = data.azurerm_storage_account.tfstate.id     # Use storage_account_id (new recommended way)
  container_access_type = "private"
}