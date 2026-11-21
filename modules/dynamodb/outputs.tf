output "table_name" {
  description = "Name of the DynamoDB table"
  value       = var.create_table ? aws_dynamodb_table.this[0].name : null
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = var.create_table ? aws_dynamodb_table.this[0].arn : null
}
