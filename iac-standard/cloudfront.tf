module "STANDARD_CLOUDFRONT" {
  source                         = "../modules/cloudfront"
  create_distribution            = var.enable_cloudfront ? true : false
  s3_bucket_id                   = module.STANDARD_S3_HELM_CHARTS.bucket_id
  s3_bucket_arn                  = module.STANDARD_S3_HELM_CHARTS.bucket_arn
  s3_bucket_regional_domain_name = module.STANDARD_S3_HELM_CHARTS.bucket_regional_domain_name

  comment = "${var.environment}-cloudfront"

  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-cloudfront"
  }
}
