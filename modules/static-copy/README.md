<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# static-copy

This module copies static files according to the specified system type.

## References

### Data Sources

- [local\_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file )

### Resourdes

- [local\_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)

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
| [local_file.write](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.read](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_from"></a> [from](#input\_from) | n/a | `string` | n/a | yes |
| <a name="input_to"></a> [to](#input\_to) | n/a | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | n/a | `list(string)` | n/a | yes |
| <a name="input_write"></a> [write](#input\_write) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_read"></a> [read](#output\_read) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
