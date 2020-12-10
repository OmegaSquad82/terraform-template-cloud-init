terraform {
  required_providers {
    cloudinit = {
      source = "hashicorp/cloudinit"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}
