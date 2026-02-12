module "DEV_EKS" {
  source = "../modules/eks"
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
}

output "DEV_EKS" {
  value = module.DEV_EKS.cluster_name
}