module "DEV_SG" {
  source = "../modules/security-group"
  create_security_group = var.pb_enable_dev_ec2_sg && var.pb_enable_dev_vpc ? true : false
  name = "${var.environment}-devops-sg"
  description = "Security group for DevOps EC2"
  vpc_id = module.DEV_VPC.vpc_id
  ingress_rules = [
    {
      name = "SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "HTTP"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "Custom"
      from_port = 30007
      to_port = 30007
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "K3s API"
      from_port = 6443
      to_port = 6443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "NodePort"
      from_port = 30000
      to_port = 32767
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = var.environment
    Terraform = "true"
  }
  depends_on = [module.DEV_VPC]
}

module "DEV_ALB_SG" {
  source = "../modules/security-group"
  create_security_group = var.pb_enable_dev_alb_sg && var.pb_enable_dev_vpc ? true : false
  name = "${var.environment}-alb-sg"
  description = "ALB Security Group"
  vpc_id = module.DEV_VPC.vpc_id

  ingress_rules = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = 30007
      to_port = 30007
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = var.environment
    Terraform = "true"
  }
}