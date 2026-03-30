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
  description = <<BACKUP_VAULT
This variable is an object used to configure the Azure Data Protection Backup Vault.

- `name`                       (Required) - The name of the Backup Vault.
- `location`                   (Required) - The Azure region where the Backup Vault should be created.
- `redundancy`                 (Required) - The redundancy setting for the Backup Vault. Allowed values are `GeoRedundant`, `LocallyRedundant`, and `ZoneRedundant`.
- `immutability`               (Required) - The immutability setting for the Backup Vault. Allowed values are `Disabled`, `Locked`, and `Unlocked`.
- `soft_delete_retention_days` (Required) - The number of days for which soft-deleted backups are retained.
- `cmk_key_vault_key_id`       (Optional) - The ID of the Key Vault Key used for customer-managed key encryption. Required when `enable_customer_managed_key` is `true`.

```hcl
backup_vault = {
  name                       = "bv-example"
  location                   = "westeurope"
  redundancy                 = "GeoRedundant"
  immutability               = "Disabled"
  soft_delete_retention_days = 14
  cmk_key_vault_key_id       = null
}
```
BACKUP_VAULT
  type = object({
    name                       = string
    location                   = string
    redundancy                 = string
    immutability               = string
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
  description = <<BLOB_STORAGE_BACKUP_POLICY
A map of blob storage backup policies to create for the Backup Vault. The map key is used as the policy name.

- `retention_duration`              (Required) - The duration of the retention period, specified in ISO 8601 duration format (e.g., `P30D` for 30 days).
- `backup_repeating_time_intervals` (Required) - A list of repeating time intervals for the backup schedule in ISO 8601 format.

```hcl
blob_storage_backup_policy = {
  "daily-policy" = {
    retention_duration              = "P30D"
    backup_repeating_time_intervals = ["R/2025-02-21T14:00:00+00:00/P1D"]
  }
}
```
BLOB_STORAGE_BACKUP_POLICY
  type = map(object({
    retention_duration              = string
    backup_repeating_time_intervals = list(string)
  }))
}
