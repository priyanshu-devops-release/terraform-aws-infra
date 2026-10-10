data "aws_iam_policy" "read_only" {
  arn = var.read_only_policy_arn
}

locals {
  existing_policy_attachments = flatten([
    for group_name, policy in var.custom_policies : [
      for policy_arn in try(policy.policy_arns, []) : {
        key        = "${group_name}:${policy_arn}"
        group      = group_name
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_group_policy_attachment" "read_only" {
  for_each = var.attach_read_only_policy ? var.group_name : toset([])

  group      = each.value
  policy_arn = data.aws_iam_policy.read_only.arn
}

resource "aws_iam_policy" "custom" {
  for_each = {
    for group_name, policy in var.custom_policies :
    group_name => policy
    if try(policy.policy_json, null) != null
  }

  name   = "${each.key}-custom-policy"
  policy = each.value.policy_json
}

resource "aws_iam_group_policy_attachment" "custom" {
  for_each = merge(
    {
      for group_name, policy in var.custom_policies :
      "${group_name}:custom" => {
        group      = group_name
        policy_arn = aws_iam_policy.custom[group_name].arn
      }
      if try(policy.policy_json, null) != null
    },
    {
      for attachment in local.existing_policy_attachments :
      attachment.key => attachment
    }
  )

  group      = each.value.group
  policy_arn = each.value.policy_arn
}
