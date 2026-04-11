resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate1620sri"   # Must be globally unique and all lowercase
  resource_group_name      = "tfstate-rg"       # ← Change this if your RG name is different
  location                 = "East US 2"        # ← Change to your RG's location if different
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}