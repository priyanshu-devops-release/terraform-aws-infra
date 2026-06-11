# VPC Endpoints for SSM (Systems Manager) - Required for private EC2 instances
# These endpoints allow EC2 instances in private subnets to communicate with SSM service

# VPC Endpoint for Systems Manager Service
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = module.STANDARD_VPC.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type = "Interface"

  subnet_ids          = module.STANDARD_VPC.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.environment}-ssm-endpoint"
    Environment = var.environment
    Terraform   = "true"
  }
}

# VPC Endpoint for EC2 Messages
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = module.STANDARD_VPC.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type = "Interface"

  subnet_ids          = module.STANDARD_VPC.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.environment}-ec2messages-endpoint"
    Environment = var.environment
    Terraform   = "true"
  }
}

# VPC Endpoint for SSM Messages
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = module.STANDARD_VPC.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  subnet_ids          = module.STANDARD_VPC.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    Name        = "${var.environment}-ssmmessages-endpoint"
    Environment = var.environment
    Terraform   = "true"
  }
}

# Security Group for VPC Endpoints
resource "aws_security_group" "vpc_endpoint_sg" {
  name_prefix = "${var.environment}-vpc-endpoint-"
  description = "Security group for VPC endpoints"
  vpc_id      = module.STANDARD_VPC.vpc_id

  # Allow HTTPS from private subnets
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnets
    description = "HTTPS from private subnets for SSM endpoints"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.environment}-vpc-endpoint-sg"
    Environment = var.environment
    Terraform   = "true"
  }
}
