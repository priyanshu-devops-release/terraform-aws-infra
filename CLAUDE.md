# CLAUDE.md

Terraform (AWS, `us-west-2`) repo for a DevOps lab/dev environment. Provider `hashicorp/aws ~> 6.0`, Terraform `1.14.3` in CI (`>= 1.0` required).

## Layout

- `iac-standard/` — the **root module** (run all terraform commands here). One `.tf` file per service (`vpc.tf`, `ec2.tf`, `eks.tf`, `lambda.tf`, `dynamo.tf`, `iam.tf`, `s3.tf`, `sg.tf`, `alb.tf`, `cloudfront.tf`, `eso.tf`, `vpc-endpoints.tf`, `sns.tf`), plus `variables.tf`, `output.tf`, `provider.tf`, `terraform.tf`, `backend.tf` (empty S3 backend, configured at init).
  - `src/dynamodb_items.zip` — Lambda code (handler `app.handler`, python3.12).
  - `src/userdata.sh` — readable copy of EC2 user data (k3s + ArgoCD bootstrap). The value actually used is the base64 `EC2_USER_DATA` in the tfvars, so **editing `userdata.sh` alone changes nothing**.
- `modules/<name>/` — reusable child modules, each with `main.tf`, `variables.tf`, `outputs.tf` (iam-* and sns use `output.tf`; `s3_notification` is fully commented out).
- `environments/<env>/` — per-env `<env>.tfvars` and `<env>-remotestate.conf` (S3 backend: bucket, key, region, `use_lockfile`). Only `dev` exists, though CI offers staging/prod.

## Conventions

- Root module instances are named `STANDARD_<THING>` (e.g. `STANDARD_EC2`, `STANDARD_IAM_ROLE_LAMBDA`).
- **Feature flags**: every resource is toggled via a variable. Modules take `create_*` inputs and use `count`/conditionals; the root passes flags like `pb_enable_ec2`, `pb_enable_vpc`, `pb_enable_alb`, `enable_eso`, `enable_cloudfront`, `enable_lambda_dynamodb_lab`. Add new features the same way and default to off in `variables.tf`; turn on in tfvars.
- Resource names are `"${var.environment}-<suffix>"`. Note `environment` is `platform-dev-us-west-2` in dev tfvars (the variable default is `dev`).
- Tags: `Environment`, `Terraform = "true"` (some use lowercase `terraform`) and `name`.
- Cross-module wiring goes through module outputs (e.g. `module.STANDARD_VPC.public_subnet_ids`).
- Formatting is enforced in CI: run `terraform fmt -recursive` before committing.

## Key wiring

- EC2 (`t4g.medium`, in first public subnet) uses `STANDARD_PUBLIC_SG` and the instance profile from `STANDARD_IAM_ROLE_S3` (S3 full, CloudWatch agent, SSM core). ESO's IAM policy attaches to the same role.
- ESO module writes SSM parameters from `jenkins_github_*` / `grafana_admin_password` tfvars (demo placeholder values only; never commit real secrets).
- Lambda lab: `lambda_dynamodb_access_mode` = `full | read_only | none` controls the inline DynamoDB policy on the Lambda role (deliberately yields AccessDenied in lesser modes). Table and Lambda share the `enable_lambda_dynamodb_lab` flag.
- `modules/app-secrets` (KMS key + Secrets Manager secret; the read policy is an inline policy on `STANDARD_IAM_ROLE_S3` in `iam.tf`) is wired in `app-secrets.tf`, gated by `enable_app_secrets`; the password comes from `TF_VAR_app_db_password`, never tfvars.
- IAM users/groups/policies are gated by `enable_iam_users_groups_policy`; users and custom policies come from `iam_users` / `iam_custom_policies` tfvars.
- Security groups currently open SSH/K3s API/NodePort to `0.0.0.0/0` — lab setup, tighten before anything real.

## Commands

```sh
cd iac-standard
terraform fmt -check -recursive
terraform init -backend=false && terraform validate      # no AWS creds needed
terraform init -backend-config=../environments/dev/dev-remotestate.conf
terraform plan -var-file=../environments/dev/dev.tfvars -var public_key="$(cat ~/.ssh/<key>.pub)"
```

`public_key` has no tfvars value; CI supplies it as `TF_VAR_public_key` from `secrets.EC2_PUBLIC_KEY`.

## CI/CD (`.github/workflows/terraform-actions.yml`)

- Push to `master` → only the `validate` job (fmt check, init without backend, validate).
- Manual `workflow_dispatch` (inputs: environment, action, plan_run_id):
  - `plan`: runs plan, uploads the `.tfplan` to S3 (`secrets.TF_PLANS_BUCKET`, KMS) under `terraform-plans/<env>/<run_id>/`.
  - `apply`: requires `plan_run_id`, downloads that saved plan and applies it; gated by GitHub environment `terraform-apply-<env>` (approval).
- AWS auth via OIDC (`secrets.AWS_OIDC_ROLE`, `vars.AWS_REGION`); Slack notifications via `secrets.SLACK_WEBHOOK_URL`.
- Remote state is in S3 (no DynamoDB lock; uses `use_lockfile`). `.tfstate`, `.tfplan`, and keys are gitignored; `.terraform.lock.hcl` should be committed.

## Git

Work happens on feature branches merged to `master` via PRs.
