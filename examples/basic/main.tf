terraform {
  required_version = ">= 1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
  }
}

module "backup_vault" {
  source              = "../../"
  resource_group_name = "example-backup-vault-rg"
  backup_vault = {
    name       = "example-backup-vault"
    location   = "eastus"
    redundancy = "GeoRedundant"
  }

  blob_storage_backup_policy = {
    name               = "example-policy"
    location           = "eastus"
    retention_duration = "P30D"
  }

  tags = {
    "Environment" = "Production"
    "Owner"       = "Team A"
  }
}
