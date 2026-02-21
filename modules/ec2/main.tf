resource "aws_instance" "this" {
  count         = var.create_ec2 ? 1 : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = compact([var.security_group_id])
  associate_public_ip_address = var.enable_elastic_ip ? false : true
  key_name      = aws_key_pair.this[0].key_name
  user_data     = var.user_data_file

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
  lifecycle {
  ignore_changes = [
    ami  # also ignore AMI changes to avoid replacement
  ]
  }
}

resource "aws_key_pair" "this" {
  count     = var.create_ec2 ? 1 : 0
  key_name  = var.key_name
  public_key = var.public_key
}

resource "aws_eip" "this" {
  count    = var.create_ec2 && var.enable_elastic_ip ? 1 : 0
  domain   = "vpc"
  instance = aws_instance.this[0].id

  tags = var.tags
}