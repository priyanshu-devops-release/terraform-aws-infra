variable "cluster_name" {
    description = "The name of the EKS cluster"
}
variable "cluster_version" {
    description = "The Kubernetes version for the EKS cluster"
    default     = "1.27"
}
variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}