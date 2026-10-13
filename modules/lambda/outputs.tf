output "function_name" {
  description = "Name of the Lambda function"
  value       = var.create_function ? aws_lambda_function.this[0].function_name : null
}

output "function_arn" {
  description = "ARN of the Lambda function"
  value       = var.create_function ? aws_lambda_function.this[0].arn : null
}

output "log_group_name" {
  description = "CloudWatch log group of the Lambda function"
  value       = var.create_function ? aws_cloudwatch_log_group.this[0].name : null
}
