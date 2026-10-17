module "STANDARD_IAM_ROLE_S3" {
  source      = "../modules/iam-role"
  create_role = var.create_role
  role_name   = "${var.environment}-role"
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
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  # Read-only access to the app DB secret and its KMS key
  create_inline_policy = var.enable_app_secrets
  inline_policy_name   = "read-db-secret"
  inline_policy = var.enable_app_secrets ? jsonencode({
    Version = "2012-10-17"
    Statement = [
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
    ]
  }) : null

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