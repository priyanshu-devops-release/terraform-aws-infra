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

resource "aws_iam_user_login_profile" "users" {
  for_each = var.users

  user                    = aws_iam_user.users[each.key].name
  password_reset_required = true
  password_length         = var.console_password_length

  lifecycle {
    ignore_changes = [password_reset_required]
  }
}
