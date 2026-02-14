variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
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
variable "public" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = []
}
variable "private" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = []
}

variable "cluster_name" {
  default = "dev-eks-cluster"
}

variable "cluster_version" {
  default = "1.29"
}