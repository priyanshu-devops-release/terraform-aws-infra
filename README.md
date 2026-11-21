# terraform-dev

Terraform code for a small AWS DevOps lab environment in `us-west-2`: networking, an EC2 host running k3s + ArgoCD, optional EKS, IAM, S3, a Lambda + DynamoDB lab, SSM parameters for External Secrets Operator, and a KMS-encrypted Secrets Manager secret.

Every component is behind a feature flag, so `dev.tfvars` decides what is actually deployed.

## Repository layout

```
.github/workflows/terraform-actions.yml   CI: validate / plan / apply
environments/<env>/                       <env>.tfvars + <env>-remotestate.conf (only dev exists)
iac-standard/                             Root module (run Terraform here)
  src/                                    Lambda zip, readable copy of EC2 user data
modules/                                  Reusable child modules
```

### Modules

| Module | Purpose |
|---|---|
| `vpc`, `vpc-endpoints` | VPC, public/private subnets, endpoints |
| `security-group` | Generic SG with rule list |
| `ec2` | Instance, key pair, optional Elastic IP |
| `load-balancer` | ALB targeting the EC2 instance |
| `eks` | Optional EKS cluster |
| `iam-role`, `iam-groups`, `iam-users`, `iam-policy` | Roles, users, groups, custom policies |
| `s3`, `s3_notification` | Buckets (notifications module is commented out) |
| `cloudfront`, `sns` | CDN / SNS topic |
| `dynamodb`, `lambda` | Lambda + DynamoDB lab |
| `eso` | SSM parameters and IAM policy for External Secrets Operator |
| `app-secrets` | KMS key and Secrets Manager secret (IAM access is granted in `iam.tf`) |

## Prerequisites

- Terraform `1.14.3` (CI version; `>= 1.0` required)
- AWS provider `~> 6.0`
- AWS credentials with access to the state bucket (`pb-dev-state-bucket`) and the target account

## Usage

```sh
cd iac-standard

# Static checks, no AWS credentials needed
terraform fmt -check
terraform init -backend=false && terraform validate

# Real run
terraform init -backend-config=../environments/dev/dev-remotestate.conf
terraform plan  -var-file=../environments/dev/dev.tfvars -out=dev.tfplan
terraform apply dev.tfplan
```

Required values not in tfvars:

| Variable | When | How to supply |
|---|---|---|
| `public_key` | EC2 key pair is created | `TF_VAR_public_key` (CI: `EC2_PUBLIC_KEY` secret) |
| `app_db_password` | `enable_app_secrets = true` | `TF_VAR_app_db_password` |

Never put real secrets in tfvars. Values currently there are placeholders.

## Feature flags (dev.tfvars)

| Flag | Controls |
|---|---|
| `pb_enable_vpc` | VPC and subnets |
| `pb_enable_ec2`, `pb_enable_public_sg` | EC2 host and its security group |
| `pb_enable_alb`, `pb_enable_alb_sg` | Application load balancer |
| `pb_enable_dev_eks` | EKS cluster |
| `enable_eso`, `enable_iam_policy` | ESO SSM parameters and IAM policy |
| `enable_iam_users_groups_policy` | IAM users, groups, custom policies |
| `enable_lambda_dynamodb_lab` | Lambda, DynamoDB table, Lambda role |
| `lambda_dynamodb_access_mode` | `full`, `read_only` or `none` DynamoDB permissions for the Lambda |
| `enable_cloudfront` | CloudFront |
| `enable_app_secrets` | KMS + Secrets Manager app secret |

Check the current values in [environments/dev/dev.tfvars](environments/dev/dev.tfvars) before planning.

## CI/CD

GitHub Actions ([workflow](.github/workflows/terraform-actions.yml)):

- **Push to `master`:** format check, `init -backend=false`, `validate`.
- **Manual run, `plan`:** plans the chosen environment and uploads the plan to S3 under `terraform-plans/<env>/<run_id>/`.
- **Manual run, `apply`:** takes a `plan_run_id`, downloads that exact plan and applies it. Requires approval via the `terraform-apply-<env>` GitHub environment.

Required repository configuration:

| Name | Type | Purpose |
|---|---|---|
| `AWS_OIDC_ROLE` | secret | Role assumed via OIDC |
| `AWS_REGION` | variable | Region for AWS auth |
| `TF_PLANS_BUCKET` | secret | Bucket for saved plans |
| `EC2_PUBLIC_KEY` | secret | SSH public key for the instance |
| `SLACK_WEBHOOK_URL` | secret | Notifications |

## Adding an environment

1. Create `environments/<env>/<env>.tfvars` and `<env>-remotestate.conf` (distinct state `key`).
2. Create the matching `terraform-apply-<env>` GitHub environment.
3. Run the workflow with the new environment.

## Notes and cautions

- The security groups open SSH, the k3s API and NodePorts to `0.0.0.0/0`. This is lab-grade; restrict before real use.
- EC2 user data comes from the base64 `EC2_USER_DATA` variable in tfvars. `iac-standard/src/userdata.sh` is only a readable reference; editing it changes nothing.
- Secret values passed to Terraform end up in state. Keep the state bucket private and encrypted.
- State locking uses S3 native lockfiles (`use_lockfile = true`).
