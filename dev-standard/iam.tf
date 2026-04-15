module "DEV_STANDARD_IAM_ROLE_S3" {
  source = "../iam-role"
  create_role = var.create_role
  role_name = "${var.environment}-s3-role"
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
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  
  tags = {
    Environment = var.environment
    name        = "${var.environment}-s3-role"
    terraform   = "true"
  }
}