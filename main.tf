# main.tf - Fresh setup with backend and Cosmos DB

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend configuration - using the storage you created today
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate1620sri"
    container_name       = "tfstate-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Resource Group for your application resources
resource "azurerm_resource_group" "app" {
  name     = "app-rg"
  location = "Central US"
}

# Simple Cosmos DB Account (Serverless - good for development/testing)
resource "azurerm_cosmosdb_account" "main" {
  name                = "cosmos-1620sri"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.app.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }
}

# Simple SQL Database inside Cosmos DB
resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "mydatabase"
  resource_group_name = azurerm_resource_group.app.name
  account_name        = azurerm_cosmosdb_account.main.name
}