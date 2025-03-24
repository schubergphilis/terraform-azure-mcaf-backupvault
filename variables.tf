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
    name                       = string
    location                   = string
    redundancy                 = string
    immutability               = string // accepted values are "Disabled"", "Locked", "Unlocked"
    soft_delete_retention_days = number
    cmk_key_vault_key_id       = optional(string, null)
  })
}

variable "enable_customer_managed_key" {
  type        = bool
  description = "Whether to enable customer managed key for the backup vault."
  default     = false
}

variable "blob_storage_backup_policy" {
  type = map(object({
    retention_duration              = string
    backup_repeating_time_intervals = list(string) // example ["R/2025-02-21T14:00:00+00:00/P1D"]
  }))
}
