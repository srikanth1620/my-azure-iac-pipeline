# main.tf

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

# Use existing Resource Group for tfstate (already created)
data "azurerm_resource_group" "tfstate" {
  name = "tfstate-rg"
}

# Use existing Storage Account for backend
data "azurerm_storage_account" "tfstate" {
  name                = "tfstate1620sri"
  resource_group_name = "tfstate-rg"
}

# Use existing Container for backend
data "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-container"
  storage_account_name  = "tfstate1620sri"
}

# =============================================
# Your actual resources start here
# =============================================

# Create a new Resource Group for your application
resource "azurerm_resource_group" "app" {
  name     = "app-rg"
  location = "East US 2"
}

# Create a simple Cosmos DB Account (Serverless)
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

# Create a simple SQL Database inside Cosmos DB
resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "mydatabase"
  resource_group_name = azurerm_resource_group.app.name
  account_name        = azurerm_cosmosdb_account.main.name
}