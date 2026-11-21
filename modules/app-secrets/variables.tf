variable "create" {
  description = "Whether to create the KMS key, secret and app role"
  type        = bool
  default     = true
}

variable "kms_description" {
  description = "Description of the KMS key"
  type        = string
  default     = "Key for application secrets"
}

variable "kms_alias" {
  description = "KMS alias name without the 'alias/' prefix"
  type        = string
}

variable "enable_key_rotation" {
  description = "Enable automatic KMS key rotation"
  type        = bool
  default     = true
}

variable "kms_deletion_window_in_days" {
  description = "KMS key deletion window (7-30 days)"
  type        = number
  default     = 7
}

variable "secret_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
}

variable "secret_name_suffix" {
  description = "Short label used in the IAM policy name (read-<suffix>)"
  type        = string
  default     = "secret"
}

variable "secret_values" {
  description = "Key/value map stored as the JSON secret string"
  type        = map(string)
  sensitive   = true
}

variable "secret_recovery_window_in_days" {
  description = "Secret recovery window; 0 allows immediate deletion (lab only)"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
