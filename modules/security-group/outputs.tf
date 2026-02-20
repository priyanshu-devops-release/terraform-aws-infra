output "security_group_id" {
  value = length(aws_security_group.this) > 0 ? aws_security_group.this[0].id : null
}