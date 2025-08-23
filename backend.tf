terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate1620srigit "  # Replace with your actual name, e.g., tfstate1620sri
    container_name       = "tfstate-container"
    key                  = "terraform.tfstate"
  }
}