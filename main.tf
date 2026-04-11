   # main.tf - Minimal version (CMK removed for simplicity)

# Use existing Resource Group
data "azurerm_resource_group" "second_rg" {
  name = var.second_rg_name
}

# You can add your other resources here later
# For now, this file is just to avoid "already exists" errors
resource "azurerm_role_assignment" "service_principal_keyvault_access" {
  scope                = azurerm_key_vault.cmk_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.service_principal_id
}