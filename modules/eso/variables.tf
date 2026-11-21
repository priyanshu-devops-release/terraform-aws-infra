variable "role_name" {
  description = "Existing IAM role to attach ESO SSM read access to"
  type        = string
  default     = null
}

variable "create_iam_policy" {
  description = "Whether to create an IAM policy for ESO SSM read access"
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "AWS region used to build SSM ARNs"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "parameter_path_prefix" {
  description = "SSM path prefix for ESO parameters"
  type        = string
  default     = "/platform"
}

variable "kms_key_arn" {
  description = "Optional customer-managed KMS key ARN for SecureString parameters"
  type        = string
  default     = null
}

variable "secret_parameters" {
  description = "SecureString SSM parameters keyed by relative path (example: jenkins/github/client-id)"
  type        = map(string)
  default     = {}
}
variable "create_secret_parameters" {
  description = "Whether to create the secret parameters in SSM"
  type        = bool
  default     = false
}
variable "tags" {
  type    = map(string)
  default = {}
}