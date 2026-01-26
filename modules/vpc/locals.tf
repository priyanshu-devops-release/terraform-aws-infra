locals {
  common_tags = merge(
    {
      Environment = "dev"
      ManagedBy   = "terraform"
    },
    var.tags
  )
}