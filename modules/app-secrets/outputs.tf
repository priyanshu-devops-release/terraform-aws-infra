output "secret_arn" {
  description = "ARN of the secret"
  value       = var.create ? aws_secretsmanager_secret.this[0].arn : null
}

output "key_arn" {
  description = "ARN of the KMS key"
  value       = var.create ? aws_kms_key.this[0].arn : null
}

output "key_alias_name" {
  description = "Name of the KMS alias"
  value       = var.create ? aws_kms_alias.this[0].name : null
}
