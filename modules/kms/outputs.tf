output "key_arn" {
  description = "ARN of the KMS key"
  value       = var.create_key ? aws_kms_key.this[0].arn : null
}

output "key_id" {
  description = "ID of the KMS key"
  value       = var.create_key ? aws_kms_key.this[0].key_id : null
}

output "alias_name" {
  description = "Name of the KMS key alias"
  value       = var.create_key ? aws_kms_alias.this[0].name : null
}
