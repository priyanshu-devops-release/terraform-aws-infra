variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
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

variable "cluster_name" {
  default = "dev-eks-cluster"
}

variable "cluster_version" {
  default = "1.29"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "pb_enable_dev_vpc" {
  type    = bool
  default = false
}

variable "pb_enable_dev_eks" {
  type    = bool
  default = false
}

variable "pb_enable_dev_ec2" {
  type    = bool
  default = false
}

variable "pb_enable_dev_alb_sg" {
  type    = bool
  default = false
}
variable "pb_enable_public_sg" {
  type    = bool
  default = false
}
variable "pb_enable_private_sg" {
  type    = bool
  default = false
}
variable "pb_enable_dev_alb" {
  type    = bool
  default = false
}
variable "pb_enable_dev_elastic_ip" {
  type    = bool
  default = false
}
variable "pb_enable_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "pb_enable_dev_public_ip" {
  type    = bool
  default = false
}

variable "EC2_USER_DATA" {
  description = "Path to the EC2 user data script"
  type        = string
}


#S3 variables
variable "create_bucket" {
  description = "Whether to create the S3 bucket"
  type        = bool
  default     = false
}

variable "create_versioning" {
  description = "Whether to create versioning configuration"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "create_encryption" {
  description = "Whether to create encryption configuration"
  type        = bool
  default     = false
}

variable "create_acl" {
  description = "Whether to create ACL configuration"
  type        = bool
  default     = false
}

variable "acl" {
  description = "Canned ACL for the S3 bucket"
  type        = string
  default     = "private"
}

# IAM Role variables
variable "create_role" {
  description = "Whether to create the IAM role"
  type        = bool
  default     = false
}

# SSM Session Manager variable
variable "enable_ssm_endpoint" {
  description = "Whether to create SSM VPC endpoints..."
  type        = bool
  default     = false
}