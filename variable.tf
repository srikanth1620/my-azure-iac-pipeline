     variable "second_rg_name" {
       description = "Name of the second resource group"
       default     = "second-storage-rg"
     }

     variable "second_storage_name" {
       description = "Name of the second storage account"
       default     = "secondstorage1620sri"
     }

     variable "second_container_name" {
       description = "Name of the second Blob container"
       default     = "second-container"
     }

     variable "location" {
       description = "Azure region"
       default     = "eastus"
     }

     variable "tenant_id" {
       description = "Azure tenant ID"
       default     = "550420cd-a4f2-4642-941d-ec8d931bcceb"
     }

     variable "test_storage_name" {
       description = "Name of the test storage account"
       default     = "teststorage1620sri"
     }

     variable "test_container_name" {
       description = "Name of the test Blob container"
       default     = "test-container"
     }
     