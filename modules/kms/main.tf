data "aws_caller_identity" "current" {}

resource "aws_kms_key" "this" {
  count = var.create_key ? 1 : 0

  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnableIAMPolicies"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = ["kms:DescribeKey", "kms:Encrypt", "kms:Decrypt"]
        Resource  = "*"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}

resource "aws_kms_alias" "this" {
  count = var.create_key ? 1 : 0

  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.this[0].key_id
}
