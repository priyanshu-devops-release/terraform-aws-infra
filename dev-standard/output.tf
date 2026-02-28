# s3 Bucket for personal backups outputs
# output "DEV_S3_PERSONAL_BACKUPS" {
#   value       = module.DEV_S3_PERSONAL_BACKUPS.bucket_id
# }

# # SNS Topic ARN output
# output "DEV_SNS_TOPIC_ARN" {
#   value = module.DEV_SNS.sns_topic_arn
# }
output "DEV_VPC" {
  value = module.DEV_VPC.vpc_id
}

output "DEV_EC2" {
  value = module.DEV_EC2.public_ip
}

output "DEV_ALB_SG" {
  value = module.DEV_ALB_SG.security_group_id
}
# output "DEV_EKS" {
#   value = module.DEV_EKS.cluster_name
# }
output "DEV_SG" {
  value = module.DEV_SG.security_group_id
}