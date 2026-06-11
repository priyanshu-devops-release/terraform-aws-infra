module "STANDARD_EKS" {
  source         = "../modules/eks"
  create_cluster = var.pb_enable_dev_eks
  cluster_name   = "${var.environment}-eks"
  vpc_id         = module.STANDARD_VPC.vpc_id
  subnet_ids     = module.STANDARD_VPC.public_subnet_ids
  depends_on     = [module.STANDARD_VPC]
}