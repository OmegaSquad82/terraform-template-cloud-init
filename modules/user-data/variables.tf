variable "base64_encode" {
  default = false
  type    = bool
}

variable "config" {
  default = {}
}

variable "gzip" {
  default = false
  type    = bool
}

variable "path" {
  type = string
}

variable "write" {
  default = false
  type    = bool
}
