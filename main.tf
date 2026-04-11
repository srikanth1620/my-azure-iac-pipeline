# main.tf - Minimal clean version (no CMK)

# Use existing Resource Group
data "azurerm_resource_group" "second_rg" {
  name = var.second_rg_name
}

# This file is intentionally minimal so terraform plan/apply can succeed
# You can add your other resources later