variable "instance_name" {
    type = string
}
variable "subnet_id" {
    type = string
}
variable "security_group_id" {
    type = string
}
variable "key_name" {
    type = string
}
variable "tags" {
  type = map(string)
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
# variable "ami_id" {
#   description = "AMI ID for the EC2 instance"
#   type        = string
# }
variable "public_key" {
  description = "Public key for EC2 SSH access"
  type        = string
}