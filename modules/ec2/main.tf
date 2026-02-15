resource "aws_instance" "this" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.medium"

  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  key_name = var.key_name

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
}