resource "aws_s3_bucket" "terraform_state" {
  bucket = "pb-dev-state-bucket"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

import {
  to = aws_s3_bucket.terraform_state
  id = "pb-dev-state-bucket"
}

import {
  to = aws_s3_bucket_versioning.terraform_state
  id = "pb-dev-state-bucket"
}


# State bucket outputs
output "terraform_state" {
  value = aws_s3_bucket.terraform_state.bucket
}