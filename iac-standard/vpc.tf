module "STANDARD_VPC" {
  source               = "../modules/vpc"
  create_vpc           = var.pb_enable_vpc ? true : false
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnets
  private_subnet_cidrs = var.private_subnets
  availability_zones   = var.availability_zones
  name                 = "${var.environment}-vpc"
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}