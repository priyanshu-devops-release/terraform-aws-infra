variable "vpc_id" {
  description = "VPC ID where endpoints will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for interface endpoints"
  type        = list(string)
}

variable "route_table_ids" {
  description = "List of route table IDs for gateway endpoints"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "VPC CIDR block for security group"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "enable_ssm_endpoint" {
  description = "Whether to create SSM VPC endpoint (required for Session Manager on private EC2)"
  type        = bool
  default     = true
}

variable "create_all_ssm_endpoints" {
  description = "Whether to create all SSM endpoints (EC2Messages, SSMMessages). Set to false to save costs (~₹1,200/month)"
  type        = bool
  default     = false
}

variable "enable_s3_endpoint" {
  description = "Whether to create S3 gateway endpoint"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
