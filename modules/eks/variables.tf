variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "create_cluster" {
  type    = bool
  default = false
}

variable "name" {
  type = string
}