# Output user information (for sharing with new users)
output "users" {
  description = "Created IAM users"
  value = {
    for user_key, user in aws_iam_user.users :
    user_key => {
      user_name               = user.name
      arn                     = user.arn
      console_password        = aws_iam_user_login_profile.users[user_key].password
      password_reset_required = aws_iam_user_login_profile.users[user_key].password_reset_required
    }
  }
  sensitive = true
}

output "groups" {
  description = "Created IAM groups"
  value = {
    for group_key, group in aws_iam_group.groups :
    group_key => {
      name = group.name
      arn  = group.arn
    }
  }
}