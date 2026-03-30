output "backup_vault_id" {
  description = "The ID of the Backup Vault."
  value       = azurerm_data_protection_backup_vault.this.id
}

output "backup_vault_name" {
  description = "The name of the Backup Vault."
  value       = azurerm_data_protection_backup_vault.this.name
}

output "system_assigned_identity_id" {
  description = "The principal ID of the system-assigned managed identity of the Backup Vault."
  value       = azurerm_data_protection_backup_vault.this.identity[0].principal_id
}
