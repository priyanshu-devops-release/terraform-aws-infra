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

variable "pb_enable_vpc" {
  type    = bool
  default = false
}

variable "pb_enable_dev_eks" {
  type    = bool
  default = false
}

variable "pb_enable_ec2" {
  type    = bool
  default = false
}

variable "pb_enable_alb_sg" {
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
variable "pb_enable_alb" {
  type    = bool
  default = false
}
variable "pb_enable_elastic_ip" {
  type    = bool
  default = false
}
variable "pb_enable_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "pb_enable_public_ip" {
  type    = bool
  default = false
}

variable "key_name" {
  description = "Key pair name for SSH access to EC2"
  type        = string
  default     = null
}
variable "EC2_USER_DATA" {
  description = "Path to the EC2 user data script"
  type        = string
}

variable "create_key_pair" {
  type    = bool
  default = false
}

variable "public_key" {
  type      = string
  sensitive = true
}

variable "root_volume_size" {
  type    = number
  default = 30
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

# SSM Session Manager variable to create all endpoints (EC2Messages, SSMMessages) instead of just the core SSM endpoint - set to false to save costs (~₹1,200/month)
variable "enable_all_ssm_endpoints" {
  description = "Whether to create all SSM endpoints (EC2Messages, SSMMessages). Set to false to save costs (~₹1,200/month)"
  type        = bool
  default     = false
}

variable "create_s3_endpoint" {
  description = "Whether to create S3 gateway endpoint (always recommended for private subnets)"
  type        = bool
  default     = true
}