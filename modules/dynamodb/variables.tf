# Main create flag for table
variable "create_table" {
  description = "Whether to create the DynamoDB table"
  type        = bool
  default     = false
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Partition key attribute name"
  type        = string
  default     = "id"
}

variable "hash_key_type" {
  description = "Partition key attribute type (S, N or B)"
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "hash_key_type must be one of S, N or B."
  }
}

variable "enable_point_in_time_recovery" {
  description = "Whether to enable point-in-time recovery"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection on the table"
  type        = bool
  default     = false
}

# Tags
variable "tags" {
  description = "Tags to apply to the table"
  type        = map(string)
  default     = {}
}
