module "DEV_SG" {
  source      = "../modules/security-group"
  name        = "${var.environment}-devops-sg"
  description = "Security group for DevOps EC2"
  vpc_id      = module.DEV_VPC.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 30007
      to_port     = 30007
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

module "DEV_ALB_SG" {
  source      = "./modules/security-group"
  name        = "${var.environment}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = module.DEV_VPC.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}