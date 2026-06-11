variable "instance_name" {
    type = string
}
variable "subnet_id" {
    type = string
}
variable "security_group_id" {
    type = string
}
variable "tags" {
  type = map(string)
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "create_ec2" {
  type    = bool
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
# public_key variable removed - using SSM Session Manager instead

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2"
  type        = string
  default     = null
}

variable "enable_elastic_ip" {
  type        = bool
  description = "Enable Elastic IP for EC2, set false if EC2 is stopped frequently to avoid charges"
  default     = false
}

variable "user_data_file" {
  type        = string
  description = "Path to user data script file"
  default     = null
}

variable "enable_public_ip" {
  type        = bool
  description = "Enable public IP for EC2 instance"
  default     = true
}