# module "DEV_VPC" {
#   source = "../modules/vpc"
#   vpc_cidr             = var.vpc_cidr
#   public_subnet_cidrs  = var.public_subnets
#   private_subnet_cidrs = var.private_subnets
#   availability_zones   = var.availability_zones
#   tags = {
#     Environment = var.environment
#     Terraform   = "true"
#   }
# }


