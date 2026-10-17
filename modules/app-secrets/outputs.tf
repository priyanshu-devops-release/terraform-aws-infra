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

output "app_role_arn" {
  description = "ARN of the app IAM role"
  value       = var.create && var.create_app_role ? aws_iam_role.app[0].arn : null
}

output "app_role_name" {
  description = "Name of the app IAM role"
  value       = var.create && var.create_app_role ? aws_iam_role.app[0].name : null
}

output "instance_profile_name" {
  description = "Name of the app instance profile"
  value       = var.create && var.create_app_role && var.create_instance_profile ? aws_iam_instance_profile.app[0].name : null
}
