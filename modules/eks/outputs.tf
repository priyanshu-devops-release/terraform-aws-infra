output "this_is_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "this_is_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}