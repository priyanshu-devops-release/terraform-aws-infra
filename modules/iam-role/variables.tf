# Main create flag
variable "create_role" {
  description = "Whether to create the IAM role"
  type        = bool
  default     = true
}

# Role configuration
variable "role_name" {
  description = "Name of the IAM role"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the IAM role name"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "Trust policy document for the role (who can assume this role)"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the IAM role"
  type        = string
  default     = null
}

variable "force_detach_policies" {
  description = "Whether to force detaching policies before deletion"
  type        = bool
  default     = false
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) for the role"
  type        = number
  default     = 3600
}

variable "path" {
  description = "Path for the IAM role"
  type        = string
  default     = "/"
}

variable "permissions_boundary" {
  description = "ARN of the policy used as permissions boundary"
  type        = string
  default     = null
}

variable "create_instance_profile" {
  description = "Whether to create an EC2 instance profile for the role (disable for non-EC2 roles such as Lambda)"
  type        = bool
  default     = true
}

# Policy attachments
variable "policy_arns" {
  description = "List of policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

# Inline policy
variable "create_inline_policy" {
  description = "Whether to create an inline policy"
  type        = bool
  default     = false
}

variable "inline_policy_name" {
  description = "Name of the inline policy"
  type        = string
  default     = "inline-policy"
}

variable "inline_policy" {
  description = "Inline policy document"
  type        = string
  default     = null
}

# Tags
variable "tags" {
  description = "Tags to apply to the IAM role"
  type        = map(string)
  default     = {}
}