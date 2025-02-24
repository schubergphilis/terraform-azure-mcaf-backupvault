output "system_assigned_identity_id" {
  value = azurerm_data_protection_backup_vault.this.identity[0].principal_id
}