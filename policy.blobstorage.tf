resource "azurerm_data_protection_backup_policy_blob_storage" "this" {
  for_each                         = var.blob_storage_backup_policy != null ? var.blob_storage_backup_policy : {}
  name                             = each.key
  vault_id                         = azurerm_data_protection_backup_vault.this.id
  vault_default_retention_duration = each.value.retention_duration
  backup_repeating_time_intervals  = each.value.backup_repeating_time_intervals
}