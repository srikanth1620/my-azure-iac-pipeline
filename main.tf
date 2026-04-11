# main.tf - Clean starting point

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Use existing Resource Group for tfstate
data "azurerm_resource_group" "tfstate" {
  name = "tfstate-rg"
}

# Read existing storage account
data "azurerm_storage_account" "tfstate" {
  name                = "tfstate1620sri"
  resource_group_name = "tfstate-rg"
}

# Read existing container (do not create it again)
data "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_name  = "tfstate1620sri"
}