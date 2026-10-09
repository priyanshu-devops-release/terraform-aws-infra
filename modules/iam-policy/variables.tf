variable "attach_read_only_policy" {
  description = "Whether to attach the read-only policy to the IAM group"
  type        = bool
  default     = false
}

variable "read_only_policy_arn" {
  description = "ARN of the read-only IAM policy to attach"
  type        = string
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "group_name" {
  description = "IAM group that receives the read-only policy"
  type        = string
  default     = null
}
