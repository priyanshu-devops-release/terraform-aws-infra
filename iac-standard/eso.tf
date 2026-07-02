module "STANDARD_ESO" {
  create_secret_parameters  = var.enable_eso ? true : false
  source                    = "../modules/eso"
  role_name                 = module.STANDARD_IAM_ROLE_S3.role_name
  create_iam_policy         = var.enable_iam_policy ? true : false
  aws_region                = var.aws_region
  parameter_path_prefix     = var.eso_parameter_path_prefix
  kms_key_arn               = var.eso_kms_key_arn
  secret_parameters         = var.eso_secret_parameters
  environment               = var.environment
}