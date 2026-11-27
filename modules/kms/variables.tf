variable "create_key" {
  description = "Whether to create the KMS key and alias"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of the KMS key"
  type        = string
}

variable "alias_name" {
  description = "KMS alias without the alias/ prefix"
  type        = string
}

variable "deletion_window_in_days" {
  description = "KMS key deletion window in days"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Whether to enable automatic key rotation"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the KMS key"
  type        = map(string)
  default     = {}
}
