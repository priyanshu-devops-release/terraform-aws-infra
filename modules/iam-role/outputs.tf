output "role_id" {
  description = "ID of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].id : null
}

output "role_name" {
  description = "Name of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].name : null
}

output "role_arn" {
  description = "ARN of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].arn : null
}

output "role_unique_id" {
  description = "Unique ID of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].unique_id : null
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = var.create_role ? aws_iam_instance_profile.this[0].name : null
}

output "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = var.create_role ? aws_iam_instance_profile.this[0].arn : null
}

output "role_create_date" {
  description = "Creation date of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].create_date : null
}

output "attached_policy_arns" {
  description = "List of policy ARNs attached to the role"
  value       = var.create_role ? var.policy_arns : []
}