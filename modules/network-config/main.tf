/**
 * # network-config generator
 *
 * This module generates configuration for netplan
 *
 * ## References

 * ### Resourdes
 *
 * - [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
 */

locals {
  network_config = <<-EOS
  version: 2
  ${yamlencode(merge(
  length(var.bonds) > 0 ? { bonds = var.bonds } : {},
  length(var.bridges) > 0 ? { bridges = var.bridges } : {},
  length(var.ethernets) > 0 ? { ethernets = var.ethernets } : {},
  length(var.vlans) > 0 ? { vlans = var.vlans } : {},
  length(var.wifis) > 0 ? { wifis = var.wifis } : {},
))}
  EOS
}
resource "local_file" "network_config" {
  count = var.write ? 1 : 0

  content  = local.network_config
  filename = "${var.path}/network-config"
}
