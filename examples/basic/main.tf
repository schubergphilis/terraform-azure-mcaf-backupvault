terraform {
  required_version = ">= 1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "b5f5e722-d325-4261-98e1-81d2d707bd86"
}

module "backup_vault" {
  source              = "../../"
  resource_group_name = "example-resource-group"

  backup_vault = {
    name                       = "example-backup-vault"
    location                   = "westeurope"
    redundancy                 = "GeoRedundant"
    immutability               = "Disabled"
    soft_delete_retention_days = 14
  }

  blob_storage_backup_policy = {
    "examplepolicy" = {
      name                            = "example-policy"
      retention_duration              = "P30D"
      backup_repeating_time_intervals = ["R/2025-02-21T14:00:00+00:00/P1D"]
    }
  }

  tags = {
    "Environment" = "Production"
    "Owner"       = "Team A"
  }
}