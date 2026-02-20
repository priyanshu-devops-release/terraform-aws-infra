output "lb_dns_name" {
  value = aws_lb.this[0].dns_name
}

output "target_group_arn" {
  value = length(aws_lb_target_group.this) > 0 ? aws_lb_target_group.this[0].arn : null
}