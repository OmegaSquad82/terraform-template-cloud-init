output "network-config" {
  value     = module.network-config
  sensitive = true
}

output "static-copy" {
  value     = module.static-copy
  sensitive = true
}

output "user-data" {
  value     = module.user-data
  sensitive = true
}
