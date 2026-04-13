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

# Simple test Resource Group
resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "Central US"
}

# ─────────────────────────────────────────────────────────────
# MISCONFIGURATIONS THAT TRIVY WILL DETECT
# ─────────────────────────────────────────────────────────────

# 1. Storage Account with insecure public access settings
resource "azurerm_storage_account" "insecure" {
  name                     = "teststorage1620"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                  = "TLS1_0"                    # ← Trivy will flag (old TLS)
  allow_nested_items_to_be_public  = true                        # ← Trivy HIGH (replaced old allow_blob_public_access)
}

# 2. Network Security Group - Overly permissive (HIGH severity)
resource "azurerm_network_security_group" "insecure" {
  name                = "test-insecure-nsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  security_rule {
    name                       = "AllowAllInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"      # ← Trivy HIGH
    destination_address_prefix = "*"
  }
}

# 3. Key Vault - Missing security best practices
resource "azurerm_key_vault" "insecure" {
  name                          = "test-insecure-kv"
  location                      = azurerm_resource_group.test.location
  resource_group_name           = azurerm_resource_group.test.name
  tenant_id                     = "00000000-0000-0000-0000-000000000000"
  sku_name                      = "standard"
  purge_protection_enabled      = false      # ← Trivy flags
  soft_delete_retention_days    = 7
  public_network_access_enabled = true       # ← Trivy flags (should be false)
}

output "resource_group_name" {
  value = azurerm_resource_group.test.name
}