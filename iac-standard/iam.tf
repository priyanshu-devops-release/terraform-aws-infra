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

  tags = {
    Environment = var.environment
    name        = "${var.environment}-s3-role"
    terraform   = "true"
  }
}

module "STANDARD_IAM_USERS" {
  source = "../modules/iam-users"

  users                   = var.iam_users
  console_password_length = var.iam_console_password_length
  tags = {
    Environment = var.environment
    terraform   = "true"
  }
}

module "STANDARD_IAM_POLICY" {
  source = "../modules/iam-policy"

  user_names              = toset(keys(var.iam_users))
  attach_read_only_policy = var.iam_attach_read_only_policy

  depends_on = [module.STANDARD_IAM_USERS]
}