module "DEV-VPC" {
  source = "../modules/vpc"
  vpc_name        = var.environment
  vpc_cidr        = var.vpc_cidr
  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
output "DEV-VPC" {
  value       = module.DEV-VPC.vpc_name
}

