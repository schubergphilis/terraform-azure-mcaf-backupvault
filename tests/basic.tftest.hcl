mock_provider "azurerm" {}

variables {
  resource_group_name = "rg-test-backupvault"

  backup_vault = {
    name                       = "bv-test-basic"
    location                   = "westeurope"
    redundancy                 = "GeoRedundant"
    immutability               = "Disabled"
    soft_delete_retention_days = 14
  }

  blob_storage_backup_policy = {
    "daily-policy" = {
      retention_duration              = "P30D"
      backup_repeating_time_intervals = ["R/2025-02-21T14:00:00+00:00/P1D"]
    }
  }

  tags = {
    "Environment" = "Test"
  }
}

run "creates_backup_vault" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_vault.this.name == "bv-test-basic"
    error_message = "Backup vault name does not match expected value."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.resource_group_name == "rg-test-backupvault"
    error_message = "Resource group name does not match expected value."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.location == "westeurope"
    error_message = "Location does not match expected value."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.redundancy == "GeoRedundant"
    error_message = "Redundancy does not match expected value."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.immutability == "Disabled"
    error_message = "Immutability does not match expected value."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.datastore_type == "VaultStore"
    error_message = "Datastore type should always be VaultStore."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.cross_region_restore_enabled == true
    error_message = "Cross region restore should always be enabled."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.retention_duration_in_days == 14
    error_message = "Soft delete retention days does not match expected value."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.identity[0].type == "SystemAssigned"
    error_message = "Identity type should always be SystemAssigned."
  }
}

run "creates_blob_storage_policy" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["daily-policy"].name == "daily-policy"
    error_message = "Blob storage policy name does not match the map key."
  }

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["daily-policy"].vault_default_retention_duration == "P30D"
    error_message = "Retention duration does not match expected value."
  }
}

run "does_not_create_cmk_when_disabled" {
  command = plan

  assert {
    condition     = length(azurerm_data_protection_backup_vault_customer_managed_key.this) == 0
    error_message = "CMK resource should not be created when enable_customer_managed_key is false."
  }
}

run "tags_include_resource_type" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_vault.this.tags["Resource Type"] == "Backup Vault"
    error_message = "Tags should always include 'Resource Type = Backup Vault'."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.tags["Environment"] == "Test"
    error_message = "Custom tags should be merged into the resource tags."
  }
}

run "outputs_are_set" {
  command = plan

  assert {
    condition     = output.backup_vault_name == "bv-test-basic"
    error_message = "Output backup_vault_name should match the vault name."
  }
}
