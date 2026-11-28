variable "create_zone" {
  description = "Whether to create a public hosted zone and its records"
  type        = bool
}

variable "domain_name" {
  description = "Domain name for the public hosted zone"
  type        = string
}

variable "record_names" {
  description = "DNS labels to point to the target IPv4 address; use @ for the zone apex"
  type        = set(string)
}

variable "target_ipv4" {
  description = "IPv4 address that the A records resolve to"
  type        = string
  nullable    = true
}

variable "ec2_enabled" {
  description = "Whether the EC2 instance is enabled"
  type        = bool
}

variable "enable_public_ip" {
  description = "Whether the EC2 instance has a public IP address"
  type        = bool
}
