mock_provider "azurerm" {}

variables {
  resource_group_name = "rg-test-cmk"

  backup_vault = {
    name                       = "bv-test-cmk"
    location                   = "westeurope"
    redundancy                 = "GeoRedundant"
    immutability               = "Unlocked"
    soft_delete_retention_days = 14
    cmk_key_vault_key_id       = "https://my-keyvault.vault.azure.net/keys/my-key/abc123"
  }

  enable_customer_managed_key = true

  blob_storage_backup_policy = {
    "daily-policy" = {
      retention_duration              = "P30D"
      backup_repeating_time_intervals = ["R/2025-02-21T14:00:00+00:00/P1D"]
    }
  }
}

run "creates_cmk_when_enabled" {
  command = plan

  assert {
    condition     = length(azurerm_data_protection_backup_vault_customer_managed_key.this) == 1
    error_message = "CMK resource should be created when enable_customer_managed_key is true."
  }

  assert {
    condition     = azurerm_data_protection_backup_vault_customer_managed_key.this[0].key_vault_key_id == "https://my-keyvault.vault.azure.net/keys/my-key/abc123"
    error_message = "CMK key vault key ID does not match expected value."
  }
}

run "vault_uses_unlocked_immutability" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_vault.this.immutability == "Unlocked"
    error_message = "Immutability should be set to Unlocked for CMK-enabled vault."
  }
}
