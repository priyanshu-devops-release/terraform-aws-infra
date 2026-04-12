# Main create flag for bucket
variable "create_bucket" {
  description = "Whether to create the S3 bucket"
  type        = bool
  default     = true
}

# Bucket configuration
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = null
}

# ACL configuration
variable "create_acl" {
  description = "Whether to create ACL for the bucket"
  type        = bool
  default     = false
}

variable "acl" {
  description = "ACL for the S3 bucket"
  type        = string
  default     = "private"
}

# Versioning configuration
variable "create_versioning" {
  description = "Whether to create versioning configuration"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

# Encryption configuration
variable "create_encryption" {
  description = "Whether to create encryption configuration"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Encryption algorithm to use (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

# Public access block configuration
variable "create_public_access_block" {
  description = "Whether to create public access block configuration"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies"
  type        = bool
  default     = true
}

# Tags
variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}