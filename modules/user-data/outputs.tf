output "user_data" {
  value = data.cloudinit_config.mime_multipart.rendered
}
