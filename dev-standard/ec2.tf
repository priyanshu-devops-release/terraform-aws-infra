module "DEV_EC2" {
  source = "../modules/ec2"
  ami_id = var.ami_id
  instance_name     = "${var.environment}-dev-instance"
  instance_type     = var.instance_type
  subnet_id         = module.DEV_VPC.private_subnet_ids[0]
  security_group_id = module.DEV_ALB_SG.security_group_id
  key_name          = var.key_name

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}