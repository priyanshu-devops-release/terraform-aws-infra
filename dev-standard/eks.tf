module "DEV_EKS" {
  source = "../modules/eks"
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = var.vpc_id
  private_subnets = var.private_subnets
  vpc_cidr           = var.vpc_cidr
  azs                = var.availability_zones
}
