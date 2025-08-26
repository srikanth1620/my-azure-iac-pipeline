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

     variable "cmk_storage_name" {
       description = "Name of the CMK storage account"
       default     = "cmkstorage1620sri"
     }

     variable "cmk_container_name" {
       description = "Name of the CMK Blob container"
       default     = "cmk-container"
     }

     variable "key_vault_name" {
       description = "Name of the Key Vault for CMK"
       default     = "cmkvault1620sri"
     }

     variable "cmk_identity_name" {
       description = "Name of the user-assigned managed identity for CMK"
       default     = "cmkidentity1620sri"
     }