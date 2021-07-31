variable "bonds" {
  default = {}
  type    = map(any)
}

variable "bridges" {
  default = {}
  type    = map(any)
}

variable "ethernets" {
  default = {}
  type    = map(any)
}

variable "vlans" {
  default = {}
  type    = map(any)
}

variable "wifis" {
  default = {}
  type    = map(any)
}

variable "path" {
  type = string
}

variable "write" {
  default = false
  type    = bool
}
