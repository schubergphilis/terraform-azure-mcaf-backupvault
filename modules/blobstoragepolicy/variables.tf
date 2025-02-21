variable "blob_storage_backup_policy" {
  type = object({
    name               = string
    location           = string
    retention_duration = string
  })
}

variable "backup_vault_id" {
  type = string
}
