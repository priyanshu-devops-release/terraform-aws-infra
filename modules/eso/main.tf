data "aws_caller_identity" "current" {}

locals {
  parameter_prefix = "/${trim(var.parameter_path_prefix, "/")}"
  parameter_arn    = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter${local.parameter_prefix}/*"
}

data "aws_iam_policy_document" "this" {
  statement {
    sid     = "ReadPlatformParameters"
    effect  = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]
    resources = [local.parameter_arn]
  }

  statement {
    sid     = "DescribeParameters"
    effect  = "Allow"
    actions = [
      "ssm:DescribeParameters",
    ]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.kms_key_arn == null ? [] : [var.kms_key_arn]

    content {
      sid     = "DecryptSecureStringParameters"
      effect  = "Allow"
      actions = [
        "kms:Decrypt",
        "kms:DescribeKey",
      ]
      resources = [statement.value]
    }
  }
}

resource "aws_iam_policy" "this" {
  count      = var.create_iam_policy ? 1 : 0
  name        = "${var.environment}-eso-ssm-read"
  description = "Read-only access to ESO SSM parameters under ${local.parameter_prefix}"
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = var.role_name == null || !var.create_iam_policy ? 0 : 1
  role       = var.role_name
  policy_arn = aws_iam_policy.this[0].arn
}

resource "aws_ssm_parameter" "secret_parameters" {
  count = var.create_secret_parameters && var.secret_parameters != null ? length(var.secret_parameters) : 0
  name        = "${local.parameter_prefix}/${trim(each.key, "/")}"
  description = "Secret parameter for ESO: ${each.key}"
  type        = "SecureString"
  tier        = "Standard"
  value       = each.value
  key_id      = var.kms_key_arn
  overwrite   = true

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Scope       = "secret"
    Name        = "${var.environment}-${replace(trim(each.key, "/"), "/", "-")}"
  }
}