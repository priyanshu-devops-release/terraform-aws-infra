module "DEV_EKS" {
  source = "../modules/eks"
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = var.vpc_id
  subnet_ids         = module.DEV_VPC.this_is_private_subnet_ids
  vpc_cidr           = var.vpc_cidr
  azs                = var.availability_zones
}