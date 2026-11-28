# Configuration for vpc
pb_enable_vpc = true
aws_region    = "us-west-2"
environment   = "platform-dev-us-west-2"
# enable_nat_gateway = false
availability_zones = ["us-west-2a", "us-west-2b"]
vpc_cidr           = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]

# IAM Role configuration
create_role                    = true
enable_iam_users_groups_policy = false
iam_attach_read_only_policy    = false


# EKS Cluster configuration
cluster_version   = "1.29"
cluster_name      = "pb-dev-eks-cluster"
pb_enable_dev_eks = false

# EC2 configuration
pb_enable_ec2            = true
pb_enable_private_sg     = false
pb_enable_public_sg      = true
pb_enable_elastic_ip     = false
enable_ssm_endpoint      = false
enable_all_ssm_endpoints = false
pb_enable_public_ip      = true
enable_route53_ec2_dns   = true
route53_domain_name      = "priyanshudevops.dev"
route53_ec2_record_names = ["@", "www", "argocd", "jenkins", "chartmuseum"]
pb_enable_alb_sg         = false
pb_enable_alb            = false
pb_enable_ami_id         = "ami-03d548a9064c31703" # Amazon Linux 2 AMI (HVM), SSD Volume Type
instance_type            = "t4g.medium"
EC2_USER_DATA            = "IyEvYmluL2Jhc2gKc2V0IC1ldW8gcGlwZWZhaWwKCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIEVDMiBVc2VyIERhdGEg4oCUIExpZ2h0d2VpZ2h0IHNldHVwIGZvciB0NGcubWVkaXVtCiMgKDIgdkNQVSAvIDQgR0IgUkFNIC8gMjAgR0IgRUJTKQojIEluc3RhbGxzOiBrM3Mg4oaSIEhlbG0g4oaSIEFyZ29DRCDihpIgcm9vdC1hcHAgKEFwcCBvZiBBcHBzKQojIExvZzogL3Zhci9sb2cvaW5pdGlhbC1zZXR1cC5sb2cKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgojIOKUgOKUgCAwLiBTZW5kIGFsbCBvdXRwdXQgdG8gbG9nIGZpbGUg4pSA4pSACiMgQ2xvdWQtaW5pdCBhbHNvIGxvZ3MgdG8gL3Zhci9sb2cvY2xvdWQtaW5pdC1vdXRwdXQubG9nCkxPR19GSUxFPSIvdmFyL2xvZy9pbml0aWFsLXNldHVwLmxvZyIKZXhlYyA+PiAiJExPR19GSUxFIiAyPiYxCmVjaG8gIj09PSBpbml0aWFsLXNldHVwIHN0YXJ0ZWQgYXQgJChkYXRlKSA9PT0iCgojIOKUgOKUgCAxLiBFbmFibGUgc3dhcCAoc2FmZXR5IG5ldCBmb3IgNCBHQiBSQU0pIOKUgOKUgAppZiBbICEgLWYgL3N3YXBmaWxlIF07IHRoZW4KICBlY2hvICJDcmVhdGluZyAxIEdCIHN3YXAuLi4iCiAgZmFsbG9jYXRlIC1sIDFHIC9zd2FwZmlsZQogIGNobW9kIDYwMCAvc3dhcGZpbGUKICBta3N3YXAgL3N3YXBmaWxlCiAgc3dhcG9uIC9zd2FwZmlsZQogIGVjaG8gJy9zd2FwZmlsZSBub25lIHN3YXAgc3cgMCAwJyA+PiAvZXRjL2ZzdGFiCiAgZWNobyAndm0uc3dhcHBpbmVzcz0xMCcgPj4gL2V0Yy9zeXNjdGwuY29uZgogIHN5c2N0bCAtcApmaQoKIyDilIDilIAgMi4gSW5zdGFsbCBnaXQgKG5lZWRlZCB0byBjbG9uZSByZXBvIGZvciByb290LWFwcCBtYW5pZmVzdCkg4pSA4pSACmlmICEgY29tbWFuZCAtdiBnaXQgJj4vZGV2L251bGw7IHRoZW4KICBlY2hvICJJbnN0YWxsaW5nIGdpdC4uLiIKICB5dW0gaW5zdGFsbCAteSBnaXQgMj4vZGV2L251bGwgfHwgYXB0LWdldCB1cGRhdGUgJiYgYXB0LWdldCBpbnN0YWxsIC15IGdpdApmaQoKIyDilIDilIAgMy4gSW5zdGFsbCBrM3MgKGRpc2FibGUgdW51c2VkIGNvbXBvbmVudHMsIHNldCBldmljdGlvbiB0aHJlc2hvbGRzKSDilIDilIAKY3VybCAtc2ZMIGh0dHBzOi8vZ2V0Lmszcy5pbyB8IHNoIC1zIC0gXAogIC0td3JpdGUta3ViZWNvbmZpZy1tb2RlIDY0NCBcCiAgLS1kaXNhYmxlPW1ldHJpY3Mtc2VydmVyIFwKICAtLWt1YmVsZXQtYXJnPSJzeXN0ZW0tcmVzZXJ2ZWQ9Y3B1PTEwMG0sbWVtb3J5PTIwME1pIiBcCiAgLS1rdWJlbGV0LWFyZz0iZXZpY3Rpb24taGFyZD1tZW1vcnkuYXZhaWxhYmxlPDEwME1pLG5vZGVmcy5hdmFpbGFibGU8MTAlIiBcCiAgLS1rdWJlbGV0LWFyZz0iaW1hZ2UtZ2MtaGlnaC10aHJlc2hvbGQ9ODUiIFwKICAtLWt1YmVsZXQtYXJnPSJpbWFnZS1nYy1sb3ctdGhyZXNob2xkPTcwIgoKIyBXYWl0IGZvciBrM3Mgbm9kZSB0byBiZSBSZWFkeQpleHBvcnQgS1VCRUNPTkZJRz0vZXRjL3JhbmNoZXIvazNzL2szcy55YW1sCmVjaG8gJ2V4cG9ydCBLVUJFQ09ORklHPS9ldGMvcmFuY2hlci9rM3MvazNzLnlhbWwnID4+IC9ldGMvcHJvZmlsZQplY2hvICdleHBvcnQgS1VCRUNPTkZJRz0vZXRjL3JhbmNoZXIvazNzL2szcy55YW1sJyA+PiAvcm9vdC8uYmFzaHJjCgplY2hvICJXYWl0aW5nIGZvciBrM3Mgbm9kZSB0byBiZSBSZWFkeS4uLiIKdW50aWwga3ViZWN0bCBnZXQgbm9kZXMgLW8ganNvbnBhdGg9J3suaXRlbXNbMF0uc3RhdHVzLmNvbmRpdGlvbnNbPyhALnR5cGU9PSJSZWFkeSIpXS5zdGF0dXN9JyAyPi9kZXYvbnVsbCB8IGdyZXAgLXEgVHJ1ZTsgZG8KICBzbGVlcCA1CmRvbmUKZWNobyAiazNzIGlzIHJlYWR5LiIKCnN5c3RlbWN0bCBlbmFibGUgazNzCgojIOKUgOKUgCA0LiBDb25maWd1cmUgVHJhZWZpayB0byBleHBvc2UgcG9ydHMgODAgYW5kIDQ0MyBvbiB0aGUgaG9zdCDilIDilIAKIyAoazNzIG1hbmFnZXMgVHJhZWZpayB2aWEgSGVsbUNoYXJ0Q29uZmlnIOKAlCB0aGlzIGVuc3VyZXMgYm90aCBwb3J0cyBhcmUgYm91bmQpCmNhdCA8PCdFT0YnIHwga3ViZWN0bCBhcHBseSAtZiAtCmFwaVZlcnNpb246IGhlbG0uY2F0dGxlLmlvL3YxCmtpbmQ6IEhlbG1DaGFydENvbmZpZwptZXRhZGF0YToKICBuYW1lOiB0cmFlZmlrCiAgbmFtZXNwYWNlOiBrdWJlLXN5c3RlbQpzcGVjOgogIHZhbHVlc0NvbnRlbnQ6IHwtCiAgICBwb3J0czoKICAgICAgd2ViOgogICAgICAgIHBvcnQ6IDgwMDAKICAgICAgICBleHBvc2VkUG9ydDogODAKICAgICAgICBleHBvc2U6CiAgICAgICAgICBkZWZhdWx0OiB0cnVlCiAgICAgICAgcHJvdG9jb2w6IFRDUAogICAgICB3ZWJzZWN1cmU6CiAgICAgICAgcG9ydDogODQ0MwogICAgICAgIGV4cG9zZWRQb3J0OiA0NDMKICAgICAgICBleHBvc2U6CiAgICAgICAgICBkZWZhdWx0OiB0cnVlCiAgICAgICAgcHJvdG9jb2w6IFRDUAogICAgICAgIHRsczoKICAgICAgICAgIGVuYWJsZWQ6IHRydWUKICAgIHNlcnZpY2U6CiAgICAgIHR5cGU6IExvYWRCYWxhbmNlcgogICAgcmVzb3VyY2VzOgogICAgICByZXF1ZXN0czoKICAgICAgICBjcHU6IDI1bQogICAgICAgIG1lbW9yeTogMzJNaQogICAgICBsaW1pdHM6CiAgICAgICAgY3B1OiAxMDBtCiAgICAgICAgbWVtb3J5OiA2NE1pCkVPRgoKZWNobyAiVHJhZWZpayBjb25maWd1cmVkIGZvciBwb3J0cyA4MCAoSFRUUCkgYW5kIDQ0MyAoSFRUUFMpLiIKCiMg4pSA4pSAIDUuIEluc3RhbGwgSGVsbSDilIDilIAKY3VybCBodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaGVsbS9oZWxtL21haW4vc2NyaXB0cy9nZXQtaGVsbS0zIHwgYmFzaAoKIyDilIDilIAgNi4gSW5zdGFsbCBBcmdvQ0QgdmlhIEhlbG0gKHJlc291cmNlLWNvbnN0cmFpbmVkIGZvciA0IEdCIFJBTSkg4pSA4pSACmhlbG0gcmVwbyBhZGQgYXJnbyBodHRwczovL2FyZ29wcm9qLmdpdGh1Yi5pby9hcmdvLWhlbG0KaGVsbSByZXBvIHVwZGF0ZQoKa3ViZWN0bCBjcmVhdGUgbmFtZXNwYWNlIGFyZ29jZCB8fCB0cnVlCgpoZWxtIGluc3RhbGwgYXJnb2NkIGFyZ28vYXJnby1jZCBcCiAgLS1uYW1lc3BhY2UgYXJnb2NkIFwKICAtLXNldCBzZXJ2ZXIuaW5zZWN1cmU9dHJ1ZSBcCiAgLS1zZXQgc2VydmVyLnNlcnZpY2UudHlwZT1DbHVzdGVySVAgXAogIC0tc2V0IGRleC5lbmFibGVkPWZhbHNlIFwKICAtLXNldCBub3RpZmljYXRpb25zLmVuYWJsZWQ9ZmFsc2UgXAogIC0tc2V0IHNlcnZlci5pbmdyZXNzLmVuYWJsZWQ9dHJ1ZSBcCiAgLS1zZXQgc2VydmVyLmluZ3Jlc3MuaW5ncmVzc0NsYXNzTmFtZT10cmFlZmlrIFwKICAtLXNldCAnc2VydmVyLmluZ3Jlc3MuYW5ub3RhdGlvbnMudHJhZWZpa1wuaW5ncmVzc1wua3ViZXJuZXRlc1wuaW8vcm91dGVyXC5lbnRyeXBvaW50cz13ZWInIFwKICAtLXNldCBzZXJ2ZXIuaW5ncmVzcy5ob3N0bmFtZT1hcmdvY2QucHJpeWFuc2h1ZGV2b3BzLmRldiBcCiAgLS1zZXQgc2VydmVyLnJlc291cmNlcy5yZXF1ZXN0cy5jcHU9NTBtIFwKICAtLXNldCBzZXJ2ZXIucmVzb3VyY2VzLnJlcXVlc3RzLm1lbW9yeT02NE1pIFwKICAtLXNldCBzZXJ2ZXIucmVzb3VyY2VzLmxpbWl0cy5jcHU9MjAwbSBcCiAgLS1zZXQgc2VydmVyLnJlc291cmNlcy5saW1pdHMubWVtb3J5PTEyOE1pIFwKICAtLXNldCBjb250cm9sbGVyLnJlc291cmNlcy5yZXF1ZXN0cy5jcHU9MTAwbSBcCiAgLS1zZXQgY29udHJvbGxlci5yZXNvdXJjZXMucmVxdWVzdHMubWVtb3J5PTEyOE1pIFwKICAtLXNldCBjb250cm9sbGVyLnJlc291cmNlcy5saW1pdHMuY3B1PTUwMG0gXAogIC0tc2V0IGNvbnRyb2xsZXIucmVzb3VyY2VzLmxpbWl0cy5tZW1vcnk9MjU2TWkgXAogIC0tc2V0IHJlcG9TZXJ2ZXIucmVzb3VyY2VzLnJlcXVlc3RzLmNwdT01MG0gXAogIC0tc2V0IHJlcG9TZXJ2ZXIucmVzb3VyY2VzLnJlcXVlc3RzLm1lbW9yeT02NE1pIFwKICAtLXNldCByZXBvU2VydmVyLnJlc291cmNlcy5saW1pdHMuY3B1PTIwMG0gXAogIC0tc2V0IHJlcG9TZXJ2ZXIucmVzb3VyY2VzLmxpbWl0cy5tZW1vcnk9MTI4TWkgXAogIC0tc2V0IHJlZGlzLnJlc291cmNlcy5yZXF1ZXN0cy5jcHU9MjVtIFwKICAtLXNldCByZWRpcy5yZXNvdXJjZXMucmVxdWVzdHMubWVtb3J5PTMyTWkgXAogIC0tc2V0IHJlZGlzLnJlc291cmNlcy5saW1pdHMuY3B1PTEwMG0gXAogIC0tc2V0IHJlZGlzLnJlc291cmNlcy5saW1pdHMubWVtb3J5PTY0TWkgXAogIC0tc2V0IGFwcGxpY2F0aW9uU2V0LnJlc291cmNlcy5yZXF1ZXN0cy5jcHU9MjVtIFwKICAtLXNldCBhcHBsaWNhdGlvblNldC5yZXNvdXJjZXMucmVxdWVzdHMubWVtb3J5PTMyTWkgXAogIC0tc2V0IGFwcGxpY2F0aW9uU2V0LnJlc291cmNlcy5saW1pdHMuY3B1PTEwMG0gXAogIC0tc2V0IGFwcGxpY2F0aW9uU2V0LnJlc291cmNlcy5saW1pdHMubWVtb3J5PTY0TWkKCiMg4pSA4pSAIDcuIFdhaXQgZm9yIEFyZ29DRCB0byBiZSByZWFkeSDilIDilIAKZWNobyAiV2FpdGluZyBmb3IgQXJnb0NEIHRvIGJlIHJlYWR5Li4uIgprdWJlY3RsIHJvbGxvdXQgc3RhdHVzIGRlcGxveW1lbnQgYXJnb2NkLWFyZ28tY2Qtc2VydmVyIC1uIGFyZ29jZCAtLXRpbWVvdXQ9MzAwcwplY2hvICJBcmdvQ0QgaXMgcmVhZHkuIgoKIyDilIDilIAgOC4gQ2xvbmUgcmVwbyBhbmQgYm9vdHN0cmFwIHJvb3QtYXBwIOKUgOKUgApSRVBPX0RJUj0iL29wdC9oZWxtLWFyZ29jZCIKaWYgWyAtZCAiJFJFUE9fRElSIiBdOyB0aGVuCiAgcm0gLXJmICIkUkVQT19ESVIiCmZpCmdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vcHJpeWFuc2h1LWRldm9wcy1yZWxlYXNlL2hlbG0tYXJnb2NkLmdpdCAiJFJFUE9fRElSIgoKa3ViZWN0bCBhcHBseSAtbiBhcmdvY2QgLWYgIiR7UkVQT19ESVJ9L3Jvb3QtYXBwL3Jvb3QtYXBwLnlhbWwiCgplY2hvICI9PT0gaW5pdGlhbC1zZXR1cCBjb21wbGV0ZWQgYXQgJChkYXRlKSA9PT0iCmVjaG8gIlNldHVwIGNvbXBsZXRlLiBrM3MgKyBBcmdvQ0QgcnVubmluZyBhbmQgd2lsbCBwZXJzaXN0IGFjcm9zcyByZWJvb3RzLiIKZWNobyAiTG9nczogL3Zhci9sb2cvaW5pdGlhbC1zZXR1cC5sb2ci"
root_volume_size         = 20
trusted_ingress_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]
############ AWS KEY PAIR ##################
create_key_pair = true
key_name        = "aws-access-key"
# public_key_path = "~/.ssh/devops-dev.pub"


# S3 Bucket configuration
create_bucket              = true
create_acl                 = false
acl                        = "private"
create_versioning          = false
versioning_enabled         = false
create_encryption          = true
enable_public_access_block = false

# CloudFront configuration
enable_cloudfront = false

# ESO configuration
enable_eso                   = true
enable_iam_policy            = true
jenkins_github_client_id     = "demo-jenkins-github-client-id"
jenkins_github_client_secret = "demo-jenkins-github-client-secret"
grafana_admin_password       = "demo-grafana-admin-password"


# IAM Users configuration
iam_read_only_group_name = ["devops", "developers"]

iam_users = {
  "priyanshub.devops" = {
    full_name = "Priyanshu"
    email     = "priyanshu@company.com"
    groups    = ["devops"]
  }
  "john.developer" = {
    full_name = "John Smith"
    email     = "john@company.com"
    groups    = ["developers"]
  }
  "sarah.engineer" = {
    full_name = "Sarah Johnson"
    email     = "sarah@company.com"
    groups    = ["developers"]
  }
  "mike.devops" = {
    full_name = "Mike Davis"
    email     = "mike@company.com"
    groups    = ["devops"]
  }
  "alice.analyst" = {
    full_name = "Alice Smith"
    email     = "alice@company.com"
    groups    = ["devops"]
  }
}

# Custom IAM Policies configuration
iam_custom_policies = {
  devops = {
    policy_json = <<-POLICY
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Action": [
              "ec2:Describe*",
              "ec2:Get*",
              "logs:Describe*",
              "logs:Get*"
            ],
            "Resource": "*"
          }
        ]
      }
    POLICY

    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
    ]
  }

  developers = {
    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    ]
  }
}
# Lambda + DynamoDB lab configuration
enable_lambda_dynamodb_lab  = false
lambda_dynamodb_access_mode = "read_only" # full | read_only | none

# App secrets (KMS + Secrets Manager) - password via TF_VAR_app_db_password
enable_app_secrets                 = false
app_secret_recovery_window_in_days = 0


# KMS configuration
create_kms_key = true