variable "second_rg_name" {
  description = "Name of the second resource group"
  default     = "second-storage-rg"
}

variable "second_storage_name" {
  description = "Name of the second storage account"
  default     = "secondstorage1620sri2"  # Changed to a new unique name
}

variable "second_container_name" {
  description = "Name of the second Blob container"
  default     = "second-container"
}

variable "location" {
  description = "Azure region"
  default     = "eastus"
}