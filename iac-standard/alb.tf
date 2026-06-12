module "STANDARD_ALB" {
  source               = "../modules/load-balancer"
  create_load_balancer = var.pb_enable_alb ? true : false
  name                 = "${var.environment}-alb"
  vpc_id               = module.STANDARD_VPC.vpc_id
  subnet_ids           = module.STANDARD_VPC.public_subnet_ids
  security_group_id    = module.STANDARD_ALB_SG.security_group_id
  target_port          = 8080
  target_instance_id   = module.STANDARD_EC2.instance_id

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-alb"
  }
}