output "backup_vault_identity" {
  value = azurerm_data_protection_backup_vault.this.identity[0].principal_id
  description = "System Assigned Identity Principal Id of the Backup Vault"
}