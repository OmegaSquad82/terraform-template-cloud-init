variable "bonds" {
  default = {}
  type    = map
}

variable "bridges" {
  default = {}
  type    = map
}

variable "ethernets" {
  default = {}
  type    = map
}

variable "vlans" {
  default = {}
  type    = map
}

variable "wifis" {
  default = {}
  type    = map
}

variable "path" {
  type = string
}

variable "write" {
  default = false
  type    = bool
}
