/**
 * # user-data generator
 *
 * This module generates configuration for cloud-init
 *
 * ## References
 *
 * ### Data Sources
 *
 * - [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file )
 * - [cloudinit_config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/cloudinit_config )
 *
 * ### Resourdes
 *
 * - [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file )
 */
locals {
  base = "${path.module}/static"
}

data "local_file" "static_includes" {
  for_each = fileset(local.base, "**")
  filename = "${local.base}/${each.key}"
}

data "cloudinit_config" "mime_multipart" {
  gzip          = var.gzip
  base64_encode = var.base64_encode

  part {
    content  = <<-EOS
    #cloud-config
    ${yamlencode(var.config)}
    EOS
    filename = "000-config.yaml"
  }

  dynamic "part" {
    for_each = data.local_file.static_includes
    content {
      content  = part.value.content
      filename = part.key
    }
  }
}

resource "local_file" "user_data" {
  count    = var.write ? 1 : 0
  content  = data.cloudinit_config.mime_multipart.rendered
  filename = "${var.path}/user-data"
}
