variable "users" {
  description = "Map of IAM users to create, keyed by username"
  type = map(object({
    full_name = string
    email     = string
    groups    = list(string)
  }))
}

variable "console_password_length" {
  description = "Length of temporary console password"
  type        = number
  default     = 16
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}