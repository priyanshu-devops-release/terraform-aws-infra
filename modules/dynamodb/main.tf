# DynamoDB Table
resource "aws_dynamodb_table" "this" {
  count = var.create_table ? 1 : 0

  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  deletion_protection_enabled = var.deletion_protection

  tags = var.tags
}
