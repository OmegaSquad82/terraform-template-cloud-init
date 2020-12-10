/**
 * # static-copy
 *
 * This module copies static files according to the specified system type.
 *
 * ## References
 *
 * ### Data Sources
 *
 * - [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file )
 *
 * ### Resourdes
 *
 * - [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
 */
locals {
  files_per_system = { for system in var.type : system => fileset("${var.from}/${system}", "**") }
  files            = [for system, fileset in local.files_per_system : [for file in fileset : "${system}/${file}"]]
}

data "local_file" "read" {
  for_each = toset(flatten(local.files))
  filename = "${var.from}/${each.key}"
}

resource "local_file" "write" {
  for_each = { for read in data.local_file.read : read.filename => read.content if var.write }

  content  = each.value
  filename = "${var.to}/${basename(each.key)}"
}
