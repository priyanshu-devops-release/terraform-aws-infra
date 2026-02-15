module "DEV_EC2" {
  source = "../modules/ec2"
  instance_name     = "${var.environment}-dev-instance"
  subnet_id         = module.DEV_VPC.public_subnet_ids[0]
  security_group_id = module.DEV_SG.security_group_id
  key_name          = var.key_name

  tags = {
    Environment = var.environment
  }
}