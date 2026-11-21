data "aws_caller_identity" "current" {}

# KMS key
resource "aws_kms_key" "this" {
  count = var.create ? 1 : 0

  description             = var.kms_description
  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = var.kms_deletion_window_in_days

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnableIAMPolicies"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_kms_alias" "this" {
  count = var.create ? 1 : 0

  name          = "alias/${var.kms_alias}"
  target_key_id = aws_kms_key.this[0].key_id
}

# Secret
resource "aws_secretsmanager_secret" "this" {
  count = var.create ? 1 : 0

  name                    = var.secret_name
  kms_key_id              = aws_kms_key.this[0].arn
  recovery_window_in_days = var.secret_recovery_window_in_days

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  count = var.create ? 1 : 0

  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode(var.secret_values)
}
