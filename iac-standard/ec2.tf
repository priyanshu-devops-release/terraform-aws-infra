module "STANDARD_EC2" {
  source               = "../modules/ec2"
  create_ec2           = var.pb_enable_ec2 ? true : false
  ami_id               = var.pb_enable_ami_id
  instance_name        = "${var.environment}-instance"
  instance_type        = var.instance_type
  enable_public_ip     = var.pb_enable_public_ip
  enable_elastic_ip    = var.pb_enable_elastic_ip
  user_data            = var.EC2_USER_DATA
  subnet_id            = length(module.STANDARD_VPC.public_subnet_ids) > 0 ? module.STANDARD_VPC.public_subnet_ids[0] : null
  security_group_id    = module.STANDARD_PUBLIC_SG.security_group_id
  iam_instance_profile = module.STANDARD_IAM_ROLE_S3.instance_profile_name
  key_name             = var.key_name
  public_key_path      = var.public_key_path
  root_volume_size     = var.root_volume_size
  depends_on           = [module.STANDARD_PUBLIC_SG, module.STANDARD_IAM_ROLE_S3, module.STANDARD_VPC]
  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-ec2-instance"
  }
}
