module "DEV_VPC" {
  source = "../modules/vpc"
  vpc_name        = "${var.environment}-vpc"
  vpc_id          = var.vpc_id
  vpc_cidr        = var.vpc_cidr
  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}


