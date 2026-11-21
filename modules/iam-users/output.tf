output "users" {
  description = "Created IAM users and console credentials"
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
