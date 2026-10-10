data "aws_iam_policy" "read_only" {
  arn = var.read_only_policy_arn
}

resource "aws_iam_group_policy_attachment" "read_only" {
  for_each = var.attach_read_only_policy ? var.group_name : toset([])

  group      = each.value
  policy_arn = data.aws_iam_policy.read_only.arn
}
