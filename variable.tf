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

  variable "policy_test_storage_name" {
    description = "Name of the policy test storage account"
    default     = "policyteststorage1620sri"
  }

  variable "policy_test_container_name" {
    description = "Name of the policy test Blob container"
    default     = "policy-test-container"
  }