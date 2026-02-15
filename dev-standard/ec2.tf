# module "DEV_EC2" {
#   source            = "../modules/ec2"
#   instance_name     = "${var.environment}-instance"
#   instance_type     = var.instance_type
#   subnet_id         = module.DEV_VPC.private_subnet_ids[0]
#   security_group_id = module.DEV_ALB_SG.security_group_id
#   key_name          = var.key_name
#   public_key        = file("src/dev-key.pub")


#   tags = {
#     Environment = var.environment
#     Terraform   = "true"
#   }
# }