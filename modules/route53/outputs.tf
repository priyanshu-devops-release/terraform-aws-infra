output "zone_id" {
  description = "ID of the public hosted zone, or null when disabled"
  value       = var.create_zone ? aws_route53_zone.this[0].zone_id : null
}

output "name_servers" {
  description = "Nameservers to configure with the domain registrar"
  value       = var.create_zone ? aws_route53_zone.this[0].name_servers : []
}
