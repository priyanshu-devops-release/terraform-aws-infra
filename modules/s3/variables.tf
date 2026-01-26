variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "versioning" {
  type        = bool
  default     = true
}
variable "bucket_id" {
  description = "S3 bucket ID"
  type        = string
}
variable "tags" {
  type        = map(string)
  default     = {}
}

variable "create_bucket" {
  type        = bool
  description = "Whether to create the bucket"
  default     = true
}