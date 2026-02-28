module "DEV_EC2" {
  source            = "../modules/ec2"
  create_ec2        = var.pb_enable_dev_ec2 && var.pb_enable_dev_ec2_sg ? true : false
  ami_id           = var.pb_enable_ami_id
  instance_name     = "${var.environment}-instance"
  instance_type     = var.instance_type
  enable_public_ip  = var.pb_enable_dev_public_ip
  enable_elastic_ip = var.pb_enable_dev_elastic_ip
  user_data_file    = var.EC2_USER_DATA
  subnet_id         = length(module.DEV_VPC.public_subnet_ids) > 0 ? module.DEV_VPC.public_subnet_ids[0] : null
  security_group_id = module.DEV_SG.security_group_id
  key_name          = var.key_name
  public_key        = file("src/dev-key.pub")
  depends_on       = [module.DEV_SG]
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}