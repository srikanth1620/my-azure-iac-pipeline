terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.0"  # Ensure at least 3.29.0
    }
  }
}

provider "azurerm" {
  features {}
}
