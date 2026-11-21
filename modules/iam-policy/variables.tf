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
  description = "IAM groups that receive the read-only policy"
  type        = set(string)
  default     = []
}

variable "custom_policies" {
  description = "Custom policy JSON and existing policy ARNs keyed by IAM group name"
  type = map(object({
    policy_json = optional(string)
    policy_arns = optional(set(string), [])
  }))
  default = {}
}
