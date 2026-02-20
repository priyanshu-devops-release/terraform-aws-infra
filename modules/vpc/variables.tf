variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

# variable "private_subnet_cidrs" {
#   type = list(string)
# }

variable "availability_zones" {
  type = list(string)
}
variable "create_vpc" {
  type = bool
}

variable "tags" {
  type = map(string)
}
variable "create_vpc" {
  type    = bool
  default = true
}