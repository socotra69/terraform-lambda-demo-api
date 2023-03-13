variable "vpc_id" {
  type = string
}

variable "company" {
  type = string
}


variable "env" {
  type = string
}

variable "tags" {
}

variable "zone" {
  type = string
}


variable "index" {
  type    = number
  default = 1
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    label = string
  }))
}

variable "private_subnets" {
  type = list(object({
    cidr = string
    label = string
  }))
}

variable "autopublic_ip" {
  type    = bool
  default = false
}

variable "publicrtt_id" {
  type = string
}
