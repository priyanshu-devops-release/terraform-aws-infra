variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
variable "create_alb" {
  type    = bool
  default = false
}

variable "target_port" {
  type = number
}

variable "target_instance_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}