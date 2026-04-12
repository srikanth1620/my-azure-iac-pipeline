# main.tf - Fixed with explicit backend configuration

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate1620sri"
    container_name       = "tfstate-container"
    key                  = "terraform.tfstate"

    # Important: Use service principal authentication for the backend
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}
}

# Simple test Resource Group
resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "Central US"
}

output "resource_group_name" {
  value = azurerm_resource_group.test.name
}