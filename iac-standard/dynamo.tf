module "STANDARD_DYNAMODB_ITEMS" {
  source       = "../modules/dynamodb"
  create_table = var.enable_lambda_dynamodb_lab
  table_name   = "${var.environment}-items"
  hash_key     = "id"

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-items"
  }
}
