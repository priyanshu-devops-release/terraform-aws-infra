# VPC Endpoint for Systems Manager Service (REQUIRED)
resource "aws_vpc_endpoint" "ssm" {
  count             = var.create_ssm_endpoint ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type = "Interface"

  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg[0].id]
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.environment}-ssm-endpoint"
    },
    var.tags
  )
}

# VPC Endpoint for EC2 Messages (OPTIONAL - only if create_all_ssm_endpoints = true)
resource "aws_vpc_endpoint" "ec2messages" {
  count             = var.create_ssm_endpoint && var.create_all_ssm_endpoints ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type = "Interface"

  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg[0].id]
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.environment}-ec2messages-endpoint"
    },
    var.tags
  )
}

# VPC Endpoint for SSM Messages (OPTIONAL - only if create_all_ssm_endpoints = true)
resource "aws_vpc_endpoint" "ssmmessages" {
  count             = var.create_ssm_endpoint && var.create_all_ssm_endpoints ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg[0].id]
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.environment}-ssmmessages-endpoint"
    },
    var.tags
  )
}

# Gateway Endpoint for S3
resource "aws_vpc_endpoint" "s3" {
  count             = var.create_s3_endpoint ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = var.route_table_ids

  tags = merge(
    {
      Name = "${var.environment}-s3-endpoint"
    },
    var.tags
  )
}

# Security Group for VPC Endpoints
resource "aws_security_group" "vpc_endpoint_sg" {
  count       = var.create_ssm_endpoint ? 1 : 0
  name        = "${var.environment}-vpc-endpoint-sg"
  description = "Security group for VPC Endpoints"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "HTTPS from VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(
    {
      Name = "${var.environment}-vpc-endpoint-sg"
    },
    var.tags
  )
}
