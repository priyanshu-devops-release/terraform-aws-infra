output "public_ip" {
  description = "EIP if enabled, otherwise EC2 public IP (changes on restart)"
  value = length(aws_instance.this) > 0 ? (
    var.enable_elastic_ip ? aws_eip.this[0].public_ip : aws_instance.this[0].public_ip
  ) : null
}
output "private_ip" {
  value = length(aws_instance.this) > 0 ? aws_instance.this[0].private_ip : null
}
output "instance_id" {
  value = length(aws_instance.this) > 0 ? aws_instance.this[0].id : null
}