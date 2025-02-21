# terraform-azure-mcaf-backupvault
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_blobstoragebackuppolicy"></a> [blobstoragebackuppolicy](#module\_blobstoragebackuppolicy) | ./modules/blobstoragepolicy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_protection_backup_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_vault"></a> [backup\_vault](#input\_backup\_vault) | n/a | <pre>object({<br>    name       = string<br>    location   = string<br>    redundancy = string<br>  })</pre> | n/a | yes |
| <a name="input_blob_storage_backup_policy"></a> [blob\_storage\_backup\_policy](#input\_blob\_storage\_backup\_policy) | n/a | <pre>map(object({<br>    name               = string<br>    location           = string<br>    retention_duration = string<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Recovery Services Vault should be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->