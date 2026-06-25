# s3 Bucket for personal backups outputs
# output "DEV_S3_PERSONAL_BACKUPS" {
#   value       = module.DEV_S3_PERSONAL_BACKUPS.bucket_id
# }

# # SNS Topic ARN output
# output "DEV_SNS_TOPIC_ARN" {
#   value = module.DEV_SNS.sns_topic_arn
# }
output "DEV_VPC" {
  value = module.STANDARD_VPC.vpc_id
}

output "DEV_EC2" {
  value = module.STANDARD_EC2.public_ip
}

output "STANDARD_ALB_SG" {
  value = module.STANDARD_ALB_SG.security_group_id
}
# output "DEV_EKS" {
#   value = module.DEV_EKS.cluster_name
# }
output "STANDARD_PRIVATE_SG" {
  value = module.STANDARD_PRIVATE_SG.security_group_id
}
output "DEV_STANDARD_S3_HELM_CHARTS" {
  value = module.STANDARD_S3_HELM_CHARTS.bucket_id
}
output "debug_key_name" {
  value = var.key_name
}

output "debug_create_key_pair" {
  value = var.create_key_pair
}

output "STANDARD_CLOUDFRONT_DOMAIN" {
  value = module.STANDARD_CLOUDFRONT.distribution_domain_name
}
