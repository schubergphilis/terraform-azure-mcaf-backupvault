module "blobstoragebackuppolicy" {
  source                     = "./modules/blobstoragepolicy"
  for_each                   = var.blob_storage_backup_policy != null ? var.blob_storage_backup_policy : {}
  blob_storage_backup_policy = each.value
  backup_vault_id            = azurerm_data_protection_backup_vault.this.id
}

#   for_each = var.vm_backup_policy != null ? var.vm_backup_policy : {}