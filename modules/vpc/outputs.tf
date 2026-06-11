output "vpc_id" {
  value = length(aws_vpc.this) > 0 ? aws_vpc.this[0].id : null
}

output "public_subnet_ids" {
  value = length(aws_subnet.public) > 0 ? aws_subnet.public[*].id : []
}

output "private_subnet_ids" {
  value = length(aws_subnet.private) > 0 ? aws_subnet.private[*].id : []
}

output "private_route_table_ids" {
  value = length(aws_route_table.private) > 0 ? [aws_route_table.private[0].id] : []
}

output "public_route_table_ids" {
  value = length(aws_route_table.public) > 0 ? [aws_route_table.public[0].id] : []
}