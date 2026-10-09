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

output "ESO_IAM_ROLE_ARN" {
  value = var.enable_iam_policy ? module.STANDARD_IAM_ROLE_S3.role_arn : null
}

output "ESO_SSM_PARAMETER_NAMES" {
  value = var.enable_eso ? module.STANDARD_ESO.parameter_names : {}
}

output "ESO_PARAMETER_PATH_PREFIX" {
  value = var.enable_eso ? module.STANDARD_ESO.parameter_path_prefix : null
}

output "STANDARD_IAM_GROUPS_USERS" {
  description = "Created IAM users and console credentials"
  value       = module.STANDARD_IAM_USERS.users
  sensitive   = true
}
