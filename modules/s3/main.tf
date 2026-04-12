# S3 Bucket
resource "aws_s3_bucket" "this" {
  count = var.create_bucket ? 1 : 0

  bucket = var.bucket_name
  tags   = var.tags
}

# Bucket ACL (optional)
resource "aws_s3_bucket_acl" "this" {
  count = var.create_bucket && var.create_acl ? 1 : 0

  bucket = aws_s3_bucket.this[0].id
  acl    = var.acl
}

# Bucket Versioning
resource "aws_s3_bucket_versioning" "this" {
  count = var.create_bucket && var.create_versioning ? 1 : 0

  bucket = aws_s3_bucket.this[0].id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

# Bucket Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = var.create_bucket && var.create_encryption ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption_algorithm
    }
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_bucket && var.create_public_access_block ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}