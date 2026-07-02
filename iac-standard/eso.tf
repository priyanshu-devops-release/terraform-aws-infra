module "STANDARD_ESO" {
  create_secret_parameters = var.enable_eso ? true : false
  source                   = "../modules/eso"
  role_name                = module.STANDARD_IAM_ROLE_S3.role_name
  create_iam_policy        = var.enable_iam_policy ? true : false
  aws_region               = var.aws_region
  parameter_path_prefix    = var.eso_parameter_path_prefix
  kms_key_arn              = var.eso_kms_key_arn
  secret_parameters        = {
  "jenkins/github/client-id"     = var.jenkins_github_client_id
  "jenkins/github/client-secret" = var.jenkins_github_client_secret
  "grafana/admin/password"       = var.grafana_admin_password
}
  environment              = var.environment
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}