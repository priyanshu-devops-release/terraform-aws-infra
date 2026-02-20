module "DEV_EC2" {
  source            = "../modules/ec2"
  create_ec2        = var.pb_enable_dev_ec2 ? true : false
  instance_name     = "${var.environment}-instance"
  instance_type     = var.instance_type
  subnet_id         = length(module.DEV_VPC.public_subnet_ids) > 0 ? module.DEV_VPC.public_subnet_ids[0] : null
  security_group_id = module.DEV_ALB_SG.security_group_id
  key_name          = var.key_name
  public_key        = file("src/dev-key.pub")
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}