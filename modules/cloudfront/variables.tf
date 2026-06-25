# Main create flag for distribution
variable "create_distribution" {
  description = "Whether to create the CloudFront distribution"
  type        = bool
  default     = true
}

# S3 origin configuration
variable "s3_bucket_id" {
  description = "Name/ID of the S3 bucket to use as origin"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket (used for bucket policy)"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket"
  type        = string
}

# Distribution configuration
variable "default_root_object" {
  description = "Default root object for the distribution"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "Price class for the distribution (PriceClass_100, PriceClass_200, PriceClass_All)"
  type        = string
  default     = "PriceClass_100"
}

variable "comment" {
  description = "Comment for the distribution"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Whether the distribution is enabled"
  type        = bool
  default     = true
}

# Bucket policy
variable "create_bucket_policy" {
  description = "Whether to attach an S3 bucket policy granting CloudFront OAC read access"
  type        = bool
  default     = true
}

# Custom error responses (e.g., SPA routing)
variable "custom_error_responses" {
  description = "List of custom error response configurations"
  type = list(object({
    error_code            = number
    response_code         = number
    response_page_path    = string
    error_caching_min_ttl = optional(number, 300)
  }))
  default = []
}

# Tags
variable "tags" {
  description = "Tags to apply to the distribution"
  type        = map(string)
  default     = {}
}
