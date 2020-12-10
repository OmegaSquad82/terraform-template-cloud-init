<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# network-config generator

This module generates configuration for netplan

## References

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bonds | n/a | `map` | `{}` | no |
| bridges | n/a | `map` | `{}` | no |
| ethernets | n/a | `map` | `{}` | no |
| path | n/a | `string` | n/a | yes |
| vlans | n/a | `map` | `{}` | no |
| wifis | n/a | `map` | `{}` | no |
| write | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| network\_config | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
