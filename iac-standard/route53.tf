module "STANDARD_ROUTE53" {
  source           = "../modules/route53"
  create_zone      = var.enable_route53_ec2_dns
  domain_name      = var.route53_domain_name
  record_names     = var.route53_ec2_record_names
  target_ipv4      = module.STANDARD_EC2.public_ip
  ec2_enabled      = var.pb_enable_ec2
  enable_public_ip = var.pb_enable_public_ip
}

moved {
  from = aws_route53_zone.ec2_public
  to   = module.STANDARD_ROUTE53.aws_route53_zone.this
}

moved {
  from = aws_route53_record.ec2_public
  to   = module.STANDARD_ROUTE53.aws_route53_record.this
}

output "ROUTE53_EC2_DNS_NAMESERVERS" {
  description = "Route 53 nameservers to configure with the domain registrar"
  value       = module.STANDARD_ROUTE53.name_servers
}
