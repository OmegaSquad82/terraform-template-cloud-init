<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# user-data generator

This module generates configuration for cloud-init

## References

### Data Sources

- [local\_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file )
- [cloudinit\_config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/cloudinit_config )

### Resourdes

- [local\_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file )

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| cloudinit | n/a |
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base64\_encode | n/a | `bool` | `false` | no |
| config | n/a | `map` | `{}` | no |
| gzip | n/a | `bool` | `false` | no |
| path | n/a | `string` | n/a | yes |
| write | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| user\_data | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
