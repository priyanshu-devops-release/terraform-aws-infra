# VPC Endpoints Module for SSM Session Manager
# Required for private EC2 instances to access AWS Systems Manager service

module "STANDARD_VPC_ENDPOINTS" {
  source              = "../modules/vpc-endpoints"
  create_ssm_endpoint = var.enable_ssm_endpoint # Always create S3 endpoint, conditionally create SSM endpoints
  create_all_ssm_endpoints = var.enable_all_ssm_endpoints
  vpc_id              = module.STANDARD_VPC.vpc_id
  vpc_cidr            = var.vpc_cidr
  private_subnet_ids  = module.STANDARD_VPC.private_subnet_ids
  route_table_ids     = module.STANDARD_VPC.private_route_table_ids
  aws_region          = var.aws_region
  environment         = var.environment
  create_s3_endpoint  = var.create_s3_endpoint

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-vpc-endpoints"
  }

  depends_on = [module.STANDARD_VPC]
}

