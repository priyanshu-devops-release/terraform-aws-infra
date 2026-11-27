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

variable "trusted_ingress_cidrs" {
  description = "IPv4 CIDRs allowed to reach configured security-group ingress ports; empty denies all inbound traffic"
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for cidr in var.trusted_ingress_cidrs : can(cidrnetmask(cidr)) && cidr != "0.0.0.0/0"])
    error_message = "Each trusted_ingress_cidrs entry must be a valid IPv4 CIDR other than 0.0.0.0/0."
  }
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
  default   = ""
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

variable "enable_public_access_block" {
  description = "Whether to create public access block configuration"
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

variable "enable_iam_users_groups_policy" {
  description = "Whether to create IAM users, groups, and group policies"
  type        = bool
  default     = true
}

variable "iam_users" {
  description = "IAM users and groups to create"
  type = map(object({
    full_name = string
    email     = string
    groups    = list(string)
  }))
  default = {}
}

variable "iam_console_password_length" {
  description = "Length of generated IAM console passwords"
  type        = number
  default     = 16
}

variable "iam_attach_read_only_policy" {
  description = "Attach AWS ReadOnlyAccess to every IAM user"
  type        = bool
  default     = false
}

variable "iam_read_only_group_name" {
  description = "IAM groups that receive AWS ReadOnlyAccess"
  type        = set(string)
  default     = []
}

variable "iam_custom_policies" {
  description = "Custom policy JSON and existing policy ARNs keyed by IAM group name"
  type = map(object({
    policy_json = optional(string)
    policy_arns = optional(set(string), [])
  }))
  default = {}
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

# CloudFront variables
variable "enable_cloudfront" {
  description = "Whether to create the CloudFront distribution"
  type        = bool
  default     = false
}

# ESO / SSM variables
variable "enable_eso" {
  description = "Whether to create ESO IAM policy and SSM parameters"
  type        = bool
  default     = false
}

variable "enable_iam_policy" {
  description = "Whether to create IAM policy for ESO SSM read access"
  type        = bool
  default     = false
}
variable "eso_parameter_path_prefix" {
  description = "SSM path prefix for External Secrets Operator parameters"
  type        = string
  default     = "/platform"
}

variable "eso_kms_key_arn" {
  description = "Optional customer-managed KMS key ARN for SecureString SSM parameters"
  type        = string
  default     = null
}

variable "eso_secret_parameters" {
  description = "SecureString SSM parameters keyed by relative path (example: jenkins/github/client-id)"
  type        = map(string)
  default     = {}
}

variable "jenkins_github_client_id" {
  description = "GitHub client ID for Jenkins"
  type        = string
  default     = ""
}
variable "jenkins_github_client_secret" {
  description = "GitHub client secret for Jenkins"
  type        = string
  default     = ""
}
variable "grafana_admin_password" {
  description = "Admin password for Grafana"
  type        = string
  default     = ""
}
# Lambda + DynamoDB lab variables
variable "enable_lambda_dynamodb_lab" {
  description = "Whether to create the Lambda function, execution role and DynamoDB table for the lab"
  type        = bool
  default     = false
}

variable "lambda_dynamodb_access_mode" {
  description = "DynamoDB permissions for the Lambda role: full, read_only or none (use read_only/none to practice troubleshooting)"
  type        = string
  default     = "full"

  validation {
    condition     = contains(["full", "read_only", "none"], var.lambda_dynamodb_access_mode)
    error_message = "lambda_dynamodb_access_mode must be one of full, read_only or none."
  }
}

variable "enable_app_secrets" {
  description = "Create the KMS key, DB secret and app read role"
  type        = bool
  default     = false
}

variable "app_db_username" {
  description = "DB username stored in the app secret"
  type        = string
  default     = "booking_app"
}

variable "app_db_password" {
  description = "DB password stored in the app secret (supply via TF_VAR_app_db_password)"
  type        = string
  sensitive   = true
  default     = null
}

variable "app_secret_recovery_window_in_days" {
  description = "Secret recovery window; 0 allows immediate deletion (lab only)"
  type        = number
  default     = 30
}



# KMS variables
variable "create_kms_key" {
  description = "Whether to create a new KMS key"
  type        = bool
  default     = false
}