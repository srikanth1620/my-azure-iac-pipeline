  variable "second_rg_name" {
    description = "Name of the second resource group"
    default     = "second-storage-rg"
  }

  variable "location" {
    description = "Azure region"
    default     = "eastus"
  }

  variable "tenant_id" {
    description = "Azure tenant ID"
    default     = "550420cd-a4f2-4642-941d-ec8d931bcceb"
  }

  variable "second_storage_name" {
    description = "Name of the second storage account"
    default     = "secondstorage1620sri"
  }

  variable "second_container_name" {
    description = "Name of the second Blob container"
    default     = "second-container"
  }

  variable "key_vault_name" {
    description = "Name of the Key Vault for CMK"
    default     = "cmkvault1620sri"
  }