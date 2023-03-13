## common vars
variable "label" {
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

## context vars

variable "vpc_id" {
  type = string
}

variable "vpc_subnet_ids" {
  type = list(string)
}

variable "apim_sg" {
  type = string
}
variable "lambda_role" {
  type = string
}

variable "lambda_kms" {
  type = string
}


variable "pool_id" {
  type = string
}

variable "pool_endpoint" {

  type = string
}

variable "architectures" {
  type = list(string)
}


## app vars

variable "timeout" {
  type    = number
  default = 5
}


variable "memory_size" {
  type    = number
  default = 128
}


variable "image_uri" {
  type    = string
  default = null
}

variable "image_config_entry_point" {
  type    = list(string)
  default = null
}
variable "image_config_command" {
  type    = list(string)
  default = null
}
variable "image_config_working_directory" {
  type    = string
  default = null
}

## cloudwatch specific
variable "cloudwatch_logs_retention_in_days" {
  type    = number
  default = 30
}
variable "cloudwatch_logs_kms_key_id" {
  type = string
}

variable "throttling_burst_limit" {
  type    = number
  default = 10
}

variable "throttling_rate_limit" {
  type    = number
  default = 10
}
