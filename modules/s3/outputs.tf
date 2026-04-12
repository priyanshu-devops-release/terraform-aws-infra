output "bucket_id" {
  description = "Name of the S3 bucket"
  value       = var.create_bucket ? aws_s3_bucket.this[0].id : null
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = var.create_bucket ? aws_s3_bucket.this[0].arn : null
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = var.create_bucket ? aws_s3_bucket.this[0].bucket_domain_name : null
}

output "bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket"
  value       = var.create_bucket ? aws_s3_bucket.this[0].bucket_regional_domain_name : null
}

output "versioning_enabled" {
  description = "Whether versioning is enabled"
  value       = var.create_bucket && var.create_versioning ? var.versioning_enabled : false
}

output "encryption_enabled" {
  description = "Whether encryption is enabled"
  value       = var.create_bucket && var.create_encryption ? true : false
}