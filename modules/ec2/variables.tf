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