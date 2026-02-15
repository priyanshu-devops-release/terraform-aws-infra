variable "dev_vpc" {
  type    = bool
  default = false
}

module "DEV_VPC" {
  source               = "../modules/vpc"
  create_vpc           = var.dev_vpc ? true : false
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnets 
  private_subnet_cidrs = var.private_subnets
  availability_zones   = var.availability_zones
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}