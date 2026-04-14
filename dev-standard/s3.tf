module "DEV_STANDARD_S3_HELM_CHARTS" {
  create_bucket      = var.create_bucket
  source = "../modules/s3"
  bucket_name        = "${var.environment}-s3-helm-charts"
  create_versioning  = var.create_versioning
  versioning_enabled = var.versioning_enabled
  create_encryption  = var.create_encryption

  tags = {
    Environment = var.environment
    terraform   = "true"
  }
}