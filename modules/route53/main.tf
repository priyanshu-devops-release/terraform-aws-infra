resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0
  name  = var.domain_name

  lifecycle {
    precondition {
      condition     = trimspace(var.domain_name) != ""
      error_message = "domain_name must be set when create_zone is true."
    }

    precondition {
      condition     = var.ec2_enabled && var.enable_public_ip
      error_message = "Route 53 records require EC2 and its public IP to be enabled."
    }

    precondition {
      condition     = var.target_ipv4 != null && var.target_ipv4 != ""
      error_message = "target_ipv4 must be available when create_zone is true."
    }
  }
}

resource "aws_route53_record" "this" {
  for_each = var.create_zone ? var.record_names : toset([])

  zone_id = aws_route53_zone.this[0].zone_id
  name    = each.value == "@" ? var.domain_name : "${each.value}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.target_ipv4]
}
