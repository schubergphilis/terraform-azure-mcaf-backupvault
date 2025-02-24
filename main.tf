resource "azurerm_data_protection_backup_vault" "this" {
  name                         = var.backup_vault.name
  resource_group_name          = var.resource_group_name
  location                     = var.backup_vault.location
  datastore_type               = "VaultStore"
  redundancy                   = var.backup_vault.redundancy
  immutability                 = var.backup_vault.immutability
  cross_region_restore_enabled = true
  retention_duration_in_days   = var.backup_vault.soft_delete_retention_days

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    try(var.tags, {}),
    tomap({
      "Resource Type" = "Backup Vault"
    })
  )
}

resource "azurerm_data_protection_backup_vault_customer_managed_key" "this" {
  count                           = var.backup_vault.cmk_key_vault_key_id != null ? 1 : 0
  data_protection_backup_vault_id = azurerm_data_protection_backup_vault.this.id
  key_vault_key_id                = var.backup_vault.cmk_key_vault_key_id
}
