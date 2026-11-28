###############################################################################
# LAB 4: Lambda with DynamoDB access
# lambda_dynamodb_access_mode controls the execution role's table permissions:
#   full      -> get/put/delete/scan (working lab)
#   read_only -> get/scan only (put/delete fail with AccessDeniedException)
#   none      -> no DynamoDB policy (every call fails with AccessDeniedException)
###############################################################################

locals {
  lambda_dynamodb_actions = {
    full      = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem", "dynamodb:Scan"]
    read_only = ["dynamodb:GetItem", "dynamodb:Scan"]
    none      = []
  }
  lambda_dynamodb_grant = var.enable_lambda_dynamodb_lab && var.lambda_dynamodb_access_mode != "none"
}

# DynamoDB table is defined in dynamo.tf (module.STANDARD_DYNAMODB_ITEMS)

module "STANDARD_IAM_ROLE_LAMBDA" {
  source                  = "../modules/iam-role"
  create_role             = var.enable_lambda_dynamodb_lab
  create_instance_profile = false
  role_name               = "${var.environment}-lambda-dynamodb-role"
  permissions_boundary    = aws_iam_policy.app_permissions_boundary.arn
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  # CloudWatch Logs write access
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

  # Least-privilege DynamoDB access scoped to the lab table only
  create_inline_policy = local.lambda_dynamodb_grant
  inline_policy_name   = "dynamodb-items-access"
  inline_policy = local.lambda_dynamodb_grant ? jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ItemsTableAccess"
        Effect   = "Allow"
        Action   = local.lambda_dynamodb_actions[var.lambda_dynamodb_access_mode]
        Resource = module.STANDARD_DYNAMODB_ITEMS.table_arn
      }
    ]
  }) : null

  tags = {
    Environment = var.environment
    name        = "${var.environment}-lambda-dynamodb-role"
    terraform   = "true"
  }
}

module "STANDARD_LAMBDA_DYNAMODB" {
  source          = "../modules/lambda"
  create_function = var.enable_lambda_dynamodb_lab
  function_name   = "${var.environment}-dynamodb-items"
  description     = "Lab 4 - CRUD items in DynamoDB"
  role_arn        = module.STANDARD_IAM_ROLE_LAMBDA.role_arn
  filename        = "${path.module}/src/dynamodb_items.zip"
  handler         = "app.handler"
  runtime         = "python3.12"

  environment_variables = {
    TABLE_NAME = module.STANDARD_DYNAMODB_ITEMS.table_name
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-dynamodb-items"
  }
}
