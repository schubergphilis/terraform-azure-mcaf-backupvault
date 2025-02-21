resource "azurerm_data_protection_backup_policy_blob_storage" "this" {
  name                                   = var.blob_storage_backup_policy.name
  vault_id                               = var.backup_vault_id
  operational_default_retention_duration = var.blob_storage_backup_policy.retention_duration
}