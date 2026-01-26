variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "public_subnets" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}