module "STANDARD_PUBLIC_SG" {
  source                = "../modules/security-group"
  create_security_group = var.pb_enable_public_sg && var.pb_enable_vpc ? true : false
  name                  = "${var.environment}-public-sg"
  description           = "Security group for DevOps EC2"
  vpc_id                = module.STANDARD_VPC.vpc_id
  ingress_rules = length(var.trusted_ingress_cidrs) == 0 ? [] : [
    {
      name        = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      name        = "HTTP"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      name        = "K3s API"
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      name        = "NodePort"
      from_port   = 30000
      to_port     = 32767
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      name        = "ALB"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      name        = "ALB"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    }
  ]

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-public-sg"
  }
  depends_on = [module.STANDARD_VPC]
}

module "STANDARD_ALB_SG" {
  source                = "../modules/security-group"
  create_security_group = var.pb_enable_alb_sg && var.pb_enable_vpc ? true : false
  name                  = "${var.environment}-alb-sg"
  description           = "ALB Security Group"
  vpc_id                = module.STANDARD_VPC.vpc_id

  ingress_rules = length(var.trusted_ingress_cidrs) == 0 ? [] : [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
    {
      from_port   = 30007
      to_port     = 30007
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    }
  ]

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-alb-sg"
  }
}

module "STANDARD_PRIVATE_SG" {
  source                = "../modules/security-group"
  create_security_group = var.pb_enable_private_sg && var.pb_enable_vpc ? true : false
  name                  = "${var.environment}-private-sg"
  description           = "Security group for DevOps EC2"
  vpc_id                = module.STANDARD_VPC.vpc_id
  ingress_rules = length(var.trusted_ingress_cidrs) == 0 ? [] : [
    {
      name        = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.trusted_ingress_cidrs
    },
  ]

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-private-sg"
  }
  depends_on = [module.STANDARD_VPC]
}