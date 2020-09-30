variable "aws_region" {
  default = "eu-west-1"
  type    = string
}

variable "env" {
  default     = "devel"
  type        = string
  description = "environments"
}

variable "prefix" {
  default     = "uptime"
  type        = string
  description = "anything really like org or company name."
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}