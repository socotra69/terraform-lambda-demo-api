variable "env" {
  type = string
}



variable "vpc_cidr" {
  type = string
}

variable "zones" {
  type = list(string)
}

variable "public_subnets" {
}

variable "private_subnets" {

}
