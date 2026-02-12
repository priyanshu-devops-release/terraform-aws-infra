variable "cluster_name" {
    description = "The name of the EKS cluster"
}
variable "cluster_version" {
    description = "The Kubernetes version for the EKS cluster"
    default     = "1.27"
}