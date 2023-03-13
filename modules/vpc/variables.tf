variable "tags" {}

variable "env" {
  type = string
}

variable "index" {
  type    = number
  default = 1
}

variable "company" {
  type = string
}

variable "zones" {
  type = list(string)
}


variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
}

variable "private_subnets" {

}

variable "dhcp" {
  type = string
}
