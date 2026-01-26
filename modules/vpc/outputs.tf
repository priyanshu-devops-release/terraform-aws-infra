output "vpc_id" {
  value = aws_vpc.pb_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.pb_public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.pb_private[*].id
}