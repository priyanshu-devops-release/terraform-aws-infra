# IAM Role
resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                  = var.role_name
  name_prefix           = var.name_prefix
  assume_role_policy    = var.assume_role_policy
  description           = var.description
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  path                  = var.path
  permissions_boundary  = var.permissions_boundary
  tags                  = var.tags
}

# IAM Role Policy Attachments
resource "aws_iam_role_policy_attachment" "this" {
  count = var.create_role && length(var.policy_arns) > 0 ? length(var.policy_arns) : 0

  role       = aws_iam_role.this[0].name
  policy_arn = var.policy_arns[count.index]
}

# Inline IAM Role Policy
resource "aws_iam_role_policy" "this" {
  count = var.create_role && var.create_inline_policy ? 1 : 0

  name   = var.inline_policy_name
  role   = aws_iam_role.this[0].id
  policy = var.inline_policy
}