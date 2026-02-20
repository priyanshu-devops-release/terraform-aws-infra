output "cluster_name" {
  value = aws_eks_cluster.this[0].name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this[0].endpoint
}