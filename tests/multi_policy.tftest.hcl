mock_provider "azurerm" {}

variables {
  resource_group_name = "rg-test-multipolicy"

  backup_vault = {
    name                       = "bv-test-multipolicy"
    location                   = "westeurope"
    redundancy                 = "LocallyRedundant"
    immutability               = "Disabled"
    soft_delete_retention_days = 14
  }

  blob_storage_backup_policy = {
    "daily-policy" = {
      retention_duration              = "P30D"
      backup_repeating_time_intervals = ["R/2025-02-21T14:00:00+00:00/P1D"]
    }
    "weekly-policy" = {
      retention_duration              = "P90D"
      backup_repeating_time_intervals = ["R/2025-02-21T02:00:00+00:00/P7D"]
    }
    "monthly-policy" = {
      retention_duration              = "P365D"
      backup_repeating_time_intervals = ["R/2025-02-01T03:00:00+00:00/P1M"]
    }
  }
}

run "creates_all_policies" {
  command = plan

  assert {
    condition     = length(azurerm_data_protection_backup_policy_blob_storage.this) == 3
    error_message = "Should create exactly 3 blob storage backup policies."
  }
}

run "daily_policy_config" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["daily-policy"].name == "daily-policy"
    error_message = "Daily policy name should match the map key."
  }

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["daily-policy"].vault_default_retention_duration == "P30D"
    error_message = "Daily policy retention should be P30D."
  }
}

run "weekly_policy_config" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["weekly-policy"].name == "weekly-policy"
    error_message = "Weekly policy name should match the map key."
  }

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["weekly-policy"].vault_default_retention_duration == "P90D"
    error_message = "Weekly policy retention should be P90D."
  }
}

run "monthly_policy_config" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["monthly-policy"].name == "monthly-policy"
    error_message = "Monthly policy name should match the map key."
  }

  assert {
    condition     = azurerm_data_protection_backup_policy_blob_storage.this["monthly-policy"].vault_default_retention_duration == "P365D"
    error_message = "Monthly policy retention should be P365D."
  }
}

run "vault_uses_locally_redundant" {
  command = plan

  assert {
    condition     = azurerm_data_protection_backup_vault.this.redundancy == "LocallyRedundant"
    error_message = "Redundancy should be LocallyRedundant as configured."
  }
}
