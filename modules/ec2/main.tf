resource "aws_instance" "this" {
  count                       = var.create_ec2 ? 1 : 0
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = compact([var.security_group_id])
  associate_public_ip_address = var.enable_public_ip
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  user_data                   = file(var.user_data_file)
  user_data_replace_on_change = true
  depends_on                  = [ aws_key_pair.dev_key ]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
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
      associate_public_ip_address
    ]
  }
}

###############################################################################
# Elastic IP (Optional)
###############################################################################

resource "aws_eip" "this" {
  count  = var.create_ec2 && var.enable_elastic_ip ? 1 : 0
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.instance_name}-eip"
    },
    var.tags
  )
}

resource "aws_eip_association" "this" {
  count = var.create_ec2 && var.enable_elastic_ip ? 1 : 0

  instance_id   = aws_instance.this[0].id
  allocation_id = aws_eip.this[0].id
}

###############################################################################
# SSH Key Pair (Optional)
###############################################################################

resource "aws_key_pair" "dev_key" {
  count = var.create_ec2 && var.create_key_pair ? 1 : 0

  key_name   = var.key_name
  public_key = file(pathexpand(var.public_key_path))

  tags = merge(
    {
      Name = "${var.instance_name}-keypair"
    },
    var.tags
  )
}