variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}
variable "vpc_name" {
  description = "The name of the VPC"
  default     = "default-vpc"
}
variable "environment" {
  description = "The deployment environment"
  default     = "dev"
}
variable "availability_zones" {
  description = "List of availability zones to use for subnets"
  type        = list(string)
  default     = []
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = ""
}
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = []
}
variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = []
}