locals {
  path = "${path.module}/${var.output}"
}

module "network-config" {
  source   = "./modules/network-config"
  for_each = var.instances

  write = var.write
  path  = "${local.path}/${each.key}"

  ethernets = {
    for ethernet, my in try(each.value.networks.ethernets, {}) : ethernet =>
    merge(var.ethernets[each.value.netzone],
      {
        addresses = concat(my.ipv4s, my.ipv6s)
        dhcp4     = length(my.ipv4s) == 0
        dhcp6     = length(my.ipv6s) == 0
        match     = merge([for type in each.value.machine : try(var.matcher[type], {})]...)
        set-name  = ethernet
      },
    )
  }

  wifis = {
    for wifi, my in try(each.value.networks.wifis, {}) : wifi =>
    merge(var.ethernets[each.value.netzone],
      {
        addresses = concat(my.ipv4s, my.ipv6s)
        dhcp4     = length(my.ipv4s) == 0
        dhcp6     = length(my.ipv6s) == 0
        match     = merge([for type in each.value.machine : try(var.matcher[type], {})]...)
        set-name  = wifi
      },
    )
  }
}

module "user-data" {
  source   = "./modules/user-data"
  for_each = var.instances

  write = var.write
  path  = "${local.path}/${each.key}"

  # map keys will be yamlencoded in natural (alphabetical) order
  config = merge(
    # construct machine designator from key and first search domain
    { fqdn = "${each.key}.${var.ethernets[each.value.netzone].nameservers.search[0]}" },
    # gather 'bootcmd', 'runcmd' and 'packages'
    { for struct in var.structs : struct => flatten([
      # and generate them into the cloud-config
      [for type in var.types :
        # per defined 'machine', 'system and 'role'
        [for key in try(each.value[type], []) :
          # fail gracefully if keys don't exist
          try(var.config[struct][type][key], [])
    ]]]) },
    {
      byobu_by_default = var.byobu_by_default
      users            = var.users
      chpasswd         = var.chpasswd
      locale           = var.locale
      timezone         = var.timezone
      ntp              = var.ntp
      apt              = var.apt
      snap             = var.snap
      ca-certs         = var.ca_certs
      power_state      = var.power_state
    },
    var.package,
    var.ssh,
    each.value.config, # merge custom keys, overwrite above if applicable
  )
}

module "static-copy" {
  source   = "./modules/static-copy"
  for_each = var.instances

  write = var.write
  from  = "${path.module}/static"
  to    = "${local.path}/${each.key}"
  type  = concat(each.value.system, each.value.machine, each.value.roles)
}
