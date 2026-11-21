# Main create flag for function
variable "create_function" {
  description = "Whether to create the Lambda function"
  type        = bool
  default     = false
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "description" {
  description = "Description of the Lambda function"
  type        = string
  default     = null
}

variable "role_arn" {
  description = "ARN of the IAM execution role"
  type        = string
}

variable "filename" {
  description = "Path to the prebuilt deployment package (.zip)"
  type        = string
}

variable "handler" {
  description = "Function entrypoint (file.function)"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime identifier"
  type        = string
  default     = "python3.12"
}

variable "architecture" {
  description = "Instruction set architecture (arm64 or x86_64)"
  type        = string
  default     = "arm64"
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "Memory in MB"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the function"
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 14
}

# Tags
variable "tags" {
  description = "Tags to apply to Lambda resources"
  type        = map(string)
  default     = {}
}
