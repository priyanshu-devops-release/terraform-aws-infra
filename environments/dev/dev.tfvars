# Configuration for vpc
pb_enable_dev_vpc = true
aws_region = "us-west-2"
vpc_name   = "dev-vpc"
environment = "platform-dev"
enable_s3_bucket = false
enable_nat_gateway = false
availability_zones = ["us-west-2a", "us-west-2b"]
vpc_cidr = "10.0.0.0/16"
public_subnets= ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

# EKS Cluster configuration
cluster_version = "1.29"
cluster_name = "pb-dev-eks-cluster"
pb_enable_dev_eks = false

# EC2 configuration
pb_enable_dev_ec2 = true
pb_enable_dev_ec2_sg = true
pb_enable_dev_elastic_ip = true
pb_enable_dev_public_ip = false
pb_enable_dev_alb_sg = false
pb_enable_dev_alb = false
pb_enable_ami_id = "ami-03e73877aee33eaf9" # Amazon Linux 2 AMI (HVM), SSD Volume Type
key_name = "dev-key"
instance_type = "t3.medium"