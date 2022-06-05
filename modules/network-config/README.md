<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# network-config generator

This module generates configuration for netplan

## References

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.network_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bonds"></a> [bonds](#input\_bonds) | n/a | `map(any)` | `{}` | no |
| <a name="input_bridges"></a> [bridges](#input\_bridges) | n/a | `map(any)` | `{}` | no |
| <a name="input_ethernets"></a> [ethernets](#input\_ethernets) | n/a | `map(any)` | `{}` | no |
| <a name="input_path"></a> [path](#input\_path) | n/a | `string` | n/a | yes |
| <a name="input_vlans"></a> [vlans](#input\_vlans) | n/a | `map(any)` | `{}` | no |
| <a name="input_wifis"></a> [wifis](#input\_wifis) | n/a | `map(any)` | `{}` | no |
| <a name="input_write"></a> [write](#input\_write) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_config"></a> [network\_config](#output\_network\_config) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
