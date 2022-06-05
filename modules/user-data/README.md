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
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.user_data](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [cloudinit_config.mime_multipart](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [local_file.static_includes](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base64_encode"></a> [base64\_encode](#input\_base64\_encode) | n/a | `bool` | `false` | no |
| <a name="input_config"></a> [config](#input\_config) | n/a | `map` | `{}` | no |
| <a name="input_gzip"></a> [gzip](#input\_gzip) | n/a | `bool` | `false` | no |
| <a name="input_path"></a> [path](#input\_path) | n/a | `string` | n/a | yes |
| <a name="input_write"></a> [write](#input\_write) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_data"></a> [user\_data](#output\_user\_data) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
