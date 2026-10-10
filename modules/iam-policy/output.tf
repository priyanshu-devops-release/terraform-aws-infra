output "attached_policy_arn" {
  description = "ARN of the read-only policy attached to users"
  value       = var.attach_read_only_policy ? data.aws_iam_policy.read_only.arn : null
}

output "group_name" {
  description = "IAM groups receiving the read-only policy"
  value       = var.attach_read_only_policy ? var.group_name : []
}
