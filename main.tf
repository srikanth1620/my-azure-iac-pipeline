# main.tf - Fresh Backend Creation

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Create Resource Group for Terraform state
resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-rg"
  location = "Central US"
}

# 2. Create Storage Account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate1620sri"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false
}

# 3. Create Container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}