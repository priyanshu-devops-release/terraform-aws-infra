# AWS region for vpc
pb_enable_dev_vpc = true
aws_region = "us-west-2"
vpc_name   = "dev-vpc"
environment = "pb-dev"
enable_s3_bucket = false
enable_nat_gateway = true
count = 1
availability_zones = ["us-west-2a", "us-west-2b"]
vpc_cidr = "10.0.0.0/16"
public_subnets= ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

# EKS Cluster configuration
cluster_version = "1.29"
cluster_name = "pb-dev-eks-cluster"
pb_enable_dev_eks = false

# EC2 configuration
pb_enable_dev_ec2 = false
pb_enable_dev_alb_sg = false
pb_enable_dev_ec2_sg = false
pb_enable_dev_alb = false
key_name = "pb-dev-key"
instance_type = "t2.micro"
#ami_id = "ami-04144e1d88f3aa3a0" # Amazon Linux 2 AMI (HVM), SSD Volume Type