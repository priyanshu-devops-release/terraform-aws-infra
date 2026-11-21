variable "users" {
  description = "IAM users to create, keyed by username"
  type = map(object({
    full_name = string
    email     = string
  }))
  default = {}
}

variable "console_password_length" {
  description = "Length of generated IAM console passwords"
  type        = number
  default     = 16
}

variable "tags" {
  description = "Tags to apply to all IAM users"
  type        = map(string)
  default     = {}
}
