variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Recovery Services Vault should be created."
}

variable "backup_vault" {
  type = object({
    name       = string
    location   = string
    redundancy = string
  })
}

variable "blob_storage_backup_policy" {
  type = map(object({
    name               = string
    location           = string
    retention_duration = string
  }))
}
