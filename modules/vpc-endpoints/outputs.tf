output "ssm_endpoint_id" {
  description = "ID of the SSM VPC Endpoint"
  value       = try(aws_vpc_endpoint.ssm[0].id, null)
}

output "ec2messages_endpoint_id" {
  description = "ID of the EC2 Messages VPC Endpoint"
  value       = try(aws_vpc_endpoint.ec2messages[0].id, null)
}

output "ssmmessages_endpoint_id" {
  description = "ID of the SSM Messages VPC Endpoint"
  value       = try(aws_vpc_endpoint.ssmmessages[0].id, null)
}

output "s3_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = try(aws_vpc_endpoint.s3[0].id, null)
}

output "vpc_endpoint_sg_id" {
  description = "Security group ID for VPC endpoints"
  value       = try(aws_security_group.vpc_endpoint_sg[0].id, null)
}
