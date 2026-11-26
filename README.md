# IAC STACK WITH TERRAFORM

Terraform code for a small AWS DevOps lab environment in `us-west-2`: networking, an EC2 host running k3s + ArgoCD, optional EKS, IAM, S3, a Lambda + DynamoDB lab, SSM parameters for External Secrets Operator, and a KMS-encrypted Secrets Manager secret.

Every component is behind a feature flag, so `dev.tfvars` decides what is actually deployed.

## Repository layout

```
.github/workflows/terraform-actions.yml   GitHub Actions: validate / plan / apply
.gitlab-ci.yml                            GitLab CI: validate / plan / apply
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

GitLab CI ([pipeline](.gitlab-ci.yml)):

- **Push to `master`:** format check, `init -backend=false`, `validate`.
- **On each push to `master`:** format check, validate, Trivy HIGH/CRITICAL checks, and Terraform plan run automatically.
- **Terraform apply:** use the manual Play button in the same pipeline. Apply uses the plan artifact from that commit and requires protected-environment approval.
- **Protected environment:** configure `terraform-apply-<env>` with required approvers in GitLab Settings > CI/CD > Protected environments. The apply job is also serialized by `resource_group` for the selected environment.

Required GitLab CI/CD variables:

| Name | Type | Purpose |
|---|---|---|
| `AWS_OIDC_ROLE` | protected/masked variable | IAM role assumed through GitLab OIDC |
| `AWS_REGION` | variable | Region for AWS auth (defaults to `us-west-2` in `.gitlab-ci.yml`) |
| `EC2_PUBLIC_KEY` | masked variable | SSH public key for the instance |
| `APP_DB_PASSWORD` or `TF_VAR_app_db_password` | masked variable | Optional app database password when `enable_app_secrets=true` |
| `TF_VAR_trusted_ingress_cidrs` | optional variable | JSON list of IPv4 CIDRs allowed to reach security-group ingress ports; unset means no inbound access |
| `SLACK_WEBHOOK_URL` | protected/masked variable | Notifications |

Configure the AWS IAM role trust policy to accept GitLab OIDC tokens from this project and set the role audience to the GitLab server URL (`CI_SERVER_URL`, for example `https://gitlab.com`). Restrict the trust policy by subject or project claims for production.

The state bucket's default encryption uses a dedicated customer-managed KMS key. Apply the key and bucket encryption using the current backend configuration first. Then, from `iac-standard`, get the ARN with `terraform output -raw STANDARD_KMS_KEY` and grant the GitLab/GitHub OIDC role `kms:Encrypt`, `kms:Decrypt`, and `kms:GenerateDataKey` on it. These are the S3 backend's KMS use permissions; the account-root key-policy statement remains for key administration and IAM delegation. Add `kms_key_id = "<key ARN>"` to `environments/dev/dev-remotestate.conf` and run `terraform init -reconfigure -backend-config=../environments/dev/dev-remotestate.conf` so Terraform state and lock files also use the customer-managed key.

The GitLab **Run pipeline** form exposes an optional `PLAN_TARGET` field. Enter one or more valid Terraform resource addresses separated by spaces, such as `aws_s3_bucket.terraform_state aws_s3_bucket_versioning.terraform_state module.STANDARD_KMS_KEY.aws_kms_key.this[0]`, or leave it empty for a full plan. Terraform addresses do not include a `resource.` prefix. Use targeted plans only for exceptional bootstrap operations because they omit unrelated resources.

## Adding an environment

1. Create `environments/<env>/<env>.tfvars` and `<env>-remotestate.conf` (distinct state `key`).
2. Create the matching `terraform-apply-<env>` GitHub environment.
3. Create the matching `terraform-apply-<env>` protected environment in GitLab.
4. Run the GitHub workflow or GitLab web pipeline with the new environment.

## Notes and cautions

- Security-group ingress is denied by default. Set `TF_VAR_trusted_ingress_cidrs` to a JSON list of trusted IPv4 CIDRs to allow access; all configured ingress ports, including app ports, remain restricted to those ranges.
- EC2 user data comes from the base64 `EC2_USER_DATA` variable in tfvars. `iac-standard/src/userdata.sh` is only a readable reference; editing it changes nothing.
- Secret values passed to Terraform end up in state. Keep the state bucket private and encrypted.
- State locking uses S3 native lockfiles (`use_lockfile = true`).
