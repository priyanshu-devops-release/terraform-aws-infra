# VPC Endpoints Module for SSM Session Manager
# Required for private EC2 instances to access AWS Systems Manager service

module "STANDARD_VPC_ENDPOINTS" {
  source = "../modules/vpc-endpoints"

  vpc_id             = module.STANDARD_VPC.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnet_ids = module.STANDARD_VPC.private_subnet_ids
  route_table_ids    = module.STANDARD_VPC.private_route_table_ids
  aws_region         = var.aws_region
  environment        = var.environment

  enable_ssm_endpoint = var.enable_ssm_endpoint # Enable SSM endpoints when VPC is enabled
  enable_s3_endpoint  = true                    # Always enable S3 gateway endpoint

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }

  depends_on = [module.STANDARD_VPC]
}

