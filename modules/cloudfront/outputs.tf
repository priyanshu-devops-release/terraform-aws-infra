output "distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = var.create_distribution ? aws_cloudfront_distribution.this[0].id : null
}

output "distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = var.create_distribution ? aws_cloudfront_distribution.this[0].arn : null
}

output "distribution_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = var.create_distribution ? aws_cloudfront_distribution.this[0].domain_name : null
}

output "oac_id" {
  description = "ID of the Origin Access Control"
  value       = var.create_distribution ? aws_cloudfront_origin_access_control.this[0].id : null
}
