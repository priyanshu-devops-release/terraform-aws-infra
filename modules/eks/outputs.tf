output "cluster_name" {
  value = length(aws_eks_cluster.this) > 0 ? aws_eks_cluster.this[0].name : null
}

output "cluster_endpoint" {
  value = length(aws_eks_cluster.this) > 0 ? aws_eks_cluster.this[0].endpoint : null
}