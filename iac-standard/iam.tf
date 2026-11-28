data "aws_caller_identity" "current" {}

module "STANDARD_IAM_ROLE_S3" {
  source               = "../modules/iam-role"
  create_role          = var.create_role
  role_name            = "${var.environment}-role"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/app-permissions-boundary"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]

  # Scoped S3 access to the helm-charts bucket, plus read-only access to the app DB secret and its KMS key
  create_inline_policy = var.create_bucket || var.enable_app_secrets
  inline_policy_name   = "app-role-inline-policy"
  inline_policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      var.create_bucket ? [
        {
          Sid      = "ListHelmChartsBucket"
          Effect   = "Allow"
          Action   = ["s3:ListBucket"]
          Resource = module.STANDARD_S3_HELM_CHARTS.bucket_arn
        },
        {
          Sid      = "ObjectAccessHelmChartsBucket"
          Effect   = "Allow"
          Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
          Resource = "${module.STANDARD_S3_HELM_CHARTS.bucket_arn}/*"
        }
      ] : [],
      var.enable_app_secrets ? [
        {
          Sid      = "ReadOneSecret"
          Effect   = "Allow"
          Action   = ["secretsmanager:GetSecretValue"]
          Resource = module.STANDARD_APP_SECRETS.secret_arn
        },
        {
          Sid      = "DecryptWithAppKey"
          Effect   = "Allow"
          Action   = ["kms:Decrypt"]
          Resource = module.STANDARD_APP_SECRETS.key_arn
        }
      ] : []
    )
  })

  tags = {
    Environment = var.environment
    name        = "${var.environment}-s3-role"
    terraform   = "true"
  }
}

module "STANDARD_IAM_GROUPS_USERS" {
  source = "../modules/iam-groups"
  count  = var.enable_iam_users_groups_policy ? 1 : 0

  users                   = var.iam_users
  console_password_length = var.iam_console_password_length
  tags = {
    Environment = var.environment
    terraform   = "true"
  }
}

module "STANDARD_IAM_POLICY" {
  source = "../modules/iam-policy"
  count  = var.enable_iam_users_groups_policy ? 1 : 0

  attach_read_only_policy = var.iam_attach_read_only_policy
  group_name              = var.iam_read_only_group_name
  custom_policies         = var.iam_custom_policies

  depends_on = [module.STANDARD_IAM_GROUPS_USERS]
}