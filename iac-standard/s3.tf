module "STANDARD_S3_HELM_CHARTS" {
  create_bucket              = var.create_bucket
  source                     = "../modules/s3"
  bucket_name                = "${var.environment}-s3-helm-charts"
  create_versioning          = var.create_versioning
  versioning_enabled         = var.versioning_enabled
  create_encryption          = var.create_encryption
  create_public_access_block = var.enable_public_access_block
  tags = {
    Environment = var.environment
    terraform   = "true"
    name        = "${var.environment}-s3-helm-charts"
  }
}