data "azurerm_resource_group" "tfstate" {
  name = "tfstate-rg"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate1620sri"     # Must be globally unique + lowercase
  resource_group_name      = data.azurerm_resource_group.tfstate.name
  location                 = data.azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # These settings are usually required by "RequireStorageAccountEncryption" policy
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false
  infrastructure_encryption_enabled = true   # ← This is the key setting

  # Enable HTTPS only (modern way)
  https_traffic_only_enabled = true
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}