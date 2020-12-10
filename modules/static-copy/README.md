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
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| from | n/a | `string` | n/a | yes |
| to | n/a | `string` | n/a | yes |
| type | n/a | `list(string)` | n/a | yes |
| write | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| read | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
