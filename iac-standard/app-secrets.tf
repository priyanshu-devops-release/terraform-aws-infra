module "STANDARD_APP_SECRETS" {
  source                         = "../modules/app-secrets"
  create                         = var.enable_app_secrets
  kms_alias                      = "${var.environment}-app"
  kms_description                = "Key for ${var.environment} booking app secrets"
  secret_name                    = "${var.environment}/db-password"
  secret_name_suffix             = "db-secret"
  secret_values                  = { username = var.app_db_username, password = coalesce(var.app_db_password, "unset") }
  secret_recovery_window_in_days = var.app_secret_recovery_window_in_days
  app_role_name                  = "${var.environment}-app-secrets-role"
  tags = {
    Environment = var.environment
    Terraform   = "true"
    name        = "${var.environment}-app-secrets"
  }
}
