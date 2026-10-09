data "aws_iam_policy" "read_only" {
  arn = var.read_only_policy_arn
}

resource "aws_iam_group_policy_attachment" "read_only" {
  count = var.attach_read_only_policy && var.group_name != null ? 1 : 0

  group      = var.group_name
  policy_arn = data.aws_iam_policy.read_only.arn
}
