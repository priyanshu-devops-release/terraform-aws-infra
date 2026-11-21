# Create IAM users
resource "aws_iam_user" "users" {
  for_each = var.users

  name = each.key

  tags = merge(
    var.tags,
    {
      Name  = each.value.full_name
      Email = each.value.email
    }
  )
}

# Create console login profiles (passwords)
resource "aws_iam_user_login_profile" "users" {
  for_each = var.users

  user                    = aws_iam_user.users[each.key].name
  password_reset_required = true
  password_length         = var.console_password_length

  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

# Add users to groups
resource "aws_iam_user_group_membership" "users" {
  for_each = var.users

  user   = aws_iam_user.users[each.key].name
  groups = each.value.groups

  depends_on = [aws_iam_group.groups]
}

# Create groups (referenced by users)
resource "aws_iam_group" "groups" {
  for_each = toset(flatten([
    for user in var.users : user.groups
  ]))

  name = each.value
}