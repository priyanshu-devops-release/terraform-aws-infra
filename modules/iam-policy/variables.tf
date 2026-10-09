variable "user_names" {
  description = "IAM usernames to receive the read-only policy"
  type        = set(string)
  default     = []
}

variable "attach_read_only_policy" {
  description = "Whether to attach the read-only policy to the IAM users"
  type        = bool
  default     = false
}

variable "read_only_policy_arn" {
  description = "ARN of the read-only IAM policy to attach"
  type        = string
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
