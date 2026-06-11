resource "aws_instance" "this" {
  count         = var.create_ec2 ? 1 : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = compact([var.security_group_id])
  associate_public_ip_address = var.enable_public_ip
  iam_instance_profile = var.iam_instance_profile
  key_name      = null  # Using SSM Session Manager instead of SSH keys
  user_data     = var.user_data_file
  user_data_replace_on_change = true
  root_block_device {
    volume_size = 20    # ← increase from default 8GB
    volume_type = "gp3"
    delete_on_termination = true
  }
  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
  lifecycle {
  ignore_changes = [
    associate_public_ip_address,
    ami  # also ignore AMI changes to avoid replacement
  ]
  }
}

# Key pair removed - using AWS SSM Session Manager for access
# To connect: aws ssm start-session --target <instance-id>

resource "aws_eip" "this" {
  count    = var.create_ec2 && var.enable_elastic_ip ? 1 : 0
  domain   = "vpc"
  instance = aws_instance.this[0].id

  tags = var.tags
}