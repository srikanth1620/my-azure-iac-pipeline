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
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "Central US"
}

# ==================== RESOURCES THAT TRIVY WILL FLAG ====================

# 1. Storage Account - Public access + weak TLS (HIGH)
resource "azurerm_storage_account" "insecure" {
  name                     = "teststorage1620"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                  = "TLS1_0"   # Trivy flags
  allow_nested_items_to_be_public  = true       # Trivy flags as HIGH
}

# 2. NSG - Allow all traffic from internet (Classic HIGH finding)
resource "azurerm_network_security_group" "insecure" {
  name                = "test-insecure-nsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  security_rule {
    name                       = "AllowAll"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"     # Trivy HIGH
    destination_address_prefix = "*"
  }
}

# 3. Key Vault - No network restriction + no purge protection
resource "azurerm_key_vault" "insecure" {
  name                          = "test-insecure-kv"
  location                      = azurerm_resource_group.test.location
  resource_group_name           = azurerm_resource_group.test.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"

  purge_protection_enabled      = false
  soft_delete_retention_days    = 7
  public_network_access_enabled = true          # Trivy flags this
}

data "azurerm_client_config" "current" {}

output "resource_group_name" {
  value = azurerm_resource_group.test.name
}