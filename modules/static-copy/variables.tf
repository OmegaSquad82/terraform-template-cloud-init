variable "from" {
  type = string
}

variable "to" {
  type = string
}

variable "type" {
  type = list(string)
}

variable "write" {
  default = false
  type    = bool
}
