resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  key_name = aws_key_pair.this.key_name

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
}
resource "aws_key_pair" "this" {
  key_name   = "${var.environment}-key"
  public_key = var.public_key
}