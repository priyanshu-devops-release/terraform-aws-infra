# Log group created up front so retention applies (Lambda would otherwise create it with no expiry)
resource "aws_cloudwatch_log_group" "this" {
  count = var.create_function ? 1 : 0

  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

# Lambda Function
resource "aws_lambda_function" "this" {
  count = var.create_function ? 1 : 0

  function_name    = var.function_name
  description      = var.description
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  architectures    = [var.architecture]
  timeout          = var.timeout
  memory_size      = var.memory_size
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []
    content {
      variables = var.environment_variables
    }
  }

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.this[0].name
  }

  tags = var.tags
}
