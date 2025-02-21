terraform {
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4, < 5.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "b5f5e722-d325-4261-98e1-81d2d707bd86"
}