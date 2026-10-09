output "attached_policy_arn" {
  description = "ARN of the read-only policy attached to users"
  value       = var.attach_read_only_policy ? data.aws_iam_policy.read_only.arn : null
}

output "user_names" {
  description = "IAM users receiving the read-only policy"
  value       = var.attach_read_only_policy ? var.user_names : []
}
