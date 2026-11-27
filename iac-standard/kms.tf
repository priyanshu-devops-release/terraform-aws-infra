# module "STANDARD_KMS_KEY" {
#   source                  = "../modules/kms"
#   create_key              = var.create_kms_key
#   description             = "Customer-managed key for Terraform state bucket"
#   alias_name              = "${var.environment}-terraform-kms-key"
#   deletion_window_in_days = 30
#   enable_key_rotation     = true
#   tags = {
#     Environment = var.environment
#     Terraform   = "true"
#     name        = "${var.environment}-terraform-state"
#   }
# }
