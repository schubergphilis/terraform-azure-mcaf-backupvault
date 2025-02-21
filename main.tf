resource "azurerm_data_protection_backup_vault" "this" {
  name                = var.backup_vault.name
  resource_group_name = var.resource_group_name
  location            = var.backup_vault.location
  datastore_type      = "VaultStore"
  redundancy          = var.backup_vault.redundancy

  tags = merge(
    try(var.tags, {}),
    tomap({
      "Resource Type" = "Backup Vault"
    })
  )
}

