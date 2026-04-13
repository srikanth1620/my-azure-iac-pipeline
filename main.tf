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

variable "enable_insecure_resources" {
  description = "Set to true only for Trivy testing"
  type        = bool
  default     = false
}

# Simple test Resource Group
resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "Central US"
}

# ─────────────────────────────────────────────────────────────
# INSECURE RESOURCES (Only created when enable_insecure_resources = true)
# ─────────────────────────────────────────────────────────────

# 1. Insecure Storage Account
resource "azurerm_storage_account" "insecure" {
  count = var.enable_insecure_resources ? 1 : 0

  name                     = "teststorage1620"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                  = "TLS1_0"
  allow_nested_items_to_be_public  = true
}

# 2. Insecure Network Security Group
resource "azurerm_network_security_group" "insecure" {
  count = var.enable_insecure_resources ? 1 : 0

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
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# 3. Insecure Key Vault (Fixed tenant_id)
resource "azurerm_key_vault" "insecure" {
  count = var.enable_insecure_resources ? 1 : 0

  name                          = "test-insecure-kv"
  location                      = azurerm_resource_group.test.location
  resource_group_name           = azurerm_resource_group.test.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id   # ← Fixed
  sku_name                      = "standard"
  purge_protection_enabled      = false
  soft_delete_retention_days    = 7
  public_network_access_enabled = true
}

# Get current tenant_id dynamically
data "azurerm_client_config" "current" {}

output "resource_group_name" {
  value = azurerm_resource_group.test.name
}

output "insecure_resources_enabled" {
  value = var.enable_insecure_resources
}