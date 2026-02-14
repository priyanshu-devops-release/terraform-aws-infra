output "this_is_vpc_id" {
  value = aws_vpc.this.id
}

output "this_is_vpc_name" {
  value = try(aws_vpc.this.tags["Name"], aws_vpc.this.tags_all["Name"], "")
}

output "this_is_public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "this_is_private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "this_is_igw_id" {
  value = aws_internet_gateway.this.id
}

output "this_is_snat_gateway_id" {
  value = try(aws_nat_gateway.this[0].id, null)
}