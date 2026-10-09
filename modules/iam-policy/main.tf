data "aws_iam_policy" "read_only" {
  arn = var.read_only_policy_arn
}

resource "aws_iam_user_policy_attachment" "read_only" {
  for_each = var.attach_read_only_policy ? var.user_names : toset([])

  user       = each.value
  policy_arn = data.aws_iam_policy.read_only.arn
}
