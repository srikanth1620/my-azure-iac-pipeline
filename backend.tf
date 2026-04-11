data "azurerm_resource_group" "tfstate" {
  name = "tfstate-rg"   # ← Change only if your RG name is different
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate1620sri"     # Must be globally unique and lowercase
  resource_group_name      = data.azurerm_resource_group.tfstate.name
  location                 = data.azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Modern way - HTTPS traffic only is now default, so we use min_tls_version instead
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}