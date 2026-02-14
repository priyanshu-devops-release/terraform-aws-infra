module "DEV_EKS" {
  source       = "../modules/eks"
  cluster_name = "${var.environment}-eks"
  vpc_id       = module.DEV_VPC.vpc_id
  subnet_ids   = module.DEV_VPC.private_subnet_ids
}