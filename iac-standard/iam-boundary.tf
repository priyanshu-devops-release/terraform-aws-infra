locals {
  app_permissions_boundary_eso_parameter_arn = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${trim(var.eso_parameter_path_prefix, "/")}/*"
  app_permissions_boundary_cw_parameter_arn  = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/AmazonCloudWatch-*"
}

data "aws_iam_policy_document" "app_permissions_boundary" {
  statement {
    sid    = "AllowWorkloadLogging"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:PutProfileRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingStatisticSummaries",
      "xray:GetSamplingTargets",
      "xray:PutTelemetryRecords",
      "xray:PutTraceSegments",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowWorkloadLogGroups"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/*",
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/*:*",
    ]
  }

  statement {
    sid    = "AllowEKSClusterControlPlane"
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:UpdateAutoScalingGroup",
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateRoute",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteRoute",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteVolume",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeInstanceTopology",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeVpcs",
      "ec2:DetachVolume",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifyVolume",
      "ec2:RevokeSecurityGroupIngress",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
      "elasticloadbalancing:AttachLoadBalancerToSubnets",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:CreateLoadBalancerPolicy",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteLoadBalancerListeners",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancerPolicies",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DetachLoadBalancerFromSubnets",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
      "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
      "eks:DescribeCluster",
      "eks-auth:AssumeRoleForPodIdentity",
      "kms:DescribeKey",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowEKSNodeNetworking"
    effect = "Allow"
    actions = [
      "ec2:AssignPrivateIpAddresses",
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeVpcs",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:UnassignPrivateIpAddresses",
    ]
    resources = ["*"]
  }

  statement {
    sid     = "AllowEKSNetworkInterfaceTagging"
    effect  = "Allow"
    actions = ["ec2:CreateTags"]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:security-group/*",
      "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:volume/*",
    ]
  }

  statement {
    sid       = "AllowEKSOwnedNetworkInterfaceCleanup"
    effect    = "Allow"
    actions   = ["ec2:DeleteNetworkInterface"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/eks:eni:owner"
      values   = ["amazon-vpc-cni"]
    }
  }

  statement {
    sid    = "AllowEKSContainerImagePulls"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSSMInstanceCore"
    effect = "Allow"
    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
      "ssm:DescribeAssociation",
      "ssm:DescribeDocument",
      "ssm:DescribeParameters",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:GetManifest",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:PutInventory",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "AllowCloudWatchAgentParameterRead"
    effect    = "Allow"
    actions   = ["ssm:GetParameter"]
    resources = [local.app_permissions_boundary_cw_parameter_arn]
  }

  dynamic "statement" {
    for_each = var.enable_eso ? [1] : []
    content {
      sid    = "AllowESOParameterReads"
      effect = "Allow"
      actions = [
        "ssm:DescribeParameters",
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
      ]
      resources = [
        local.app_permissions_boundary_eso_parameter_arn,
      ]
    }
  }

  dynamic "statement" {
    for_each = var.create_bucket ? [1] : []
    content {
      sid       = "AllowHelmChartsBucketListing"
      effect    = "Allow"
      actions   = ["s3:ListBucket"]
      resources = [module.STANDARD_S3_HELM_CHARTS.bucket_arn]
    }
  }

  dynamic "statement" {
    for_each = var.create_bucket ? [1] : []
    content {
      sid    = "AllowHelmChartsObjectAccess"
      effect = "Allow"
      actions = [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:PutObject",
      ]
      resources = ["${module.STANDARD_S3_HELM_CHARTS.bucket_arn}/*"]
    }
  }

  dynamic "statement" {
    for_each = local.lambda_dynamodb_grant ? [1] : []
    content {
      sid       = "AllowLambdaDynamoDBLabAccess"
      effect    = "Allow"
      actions   = local.lambda_dynamodb_actions[var.lambda_dynamodb_access_mode]
      resources = [module.STANDARD_DYNAMODB_ITEMS.table_arn]
    }
  }

  dynamic "statement" {
    for_each = var.enable_app_secrets ? [1] : []
    content {
      sid       = "AllowAppSecretRead"
      effect    = "Allow"
      actions   = ["secretsmanager:GetSecretValue"]
      resources = [module.STANDARD_APP_SECRETS.secret_arn]
    }
  }

  dynamic "statement" {
    for_each = var.enable_app_secrets ? [1] : []
    content {
      sid       = "AllowAppSecretKeyDecrypt"
      effect    = "Allow"
      actions   = ["kms:Decrypt"]
      resources = [module.STANDARD_APP_SECRETS.key_arn]
    }
  }

  dynamic "statement" {
    for_each = var.enable_eso && var.eso_kms_key_arn != null && var.eso_kms_key_arn != "" ? [1] : []
    content {
      sid       = "AllowESOParameterKeyDecrypt"
      effect    = "Allow"
      actions   = ["kms:Decrypt", "kms:DescribeKey"]
      resources = [var.eso_kms_key_arn]
    }
  }

  statement {
    sid       = "AllowEKSLoadBalancerServiceLinkedRole"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = ["elasticloadbalancing.amazonaws.com"]
    }
  }

  statement {
    sid    = "DenyBoundaryRemovalAndTampering"
    effect = "Deny"
    actions = [
      "iam:DeleteRolePermissionsBoundary",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/app-permissions-boundary",
    ]
  }

  statement {
    sid     = "DenySelfAndOIDCModification"
    effect  = "Deny"
    actions = ["iam:*"]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/github-action",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/*",
    ]
    condition {
      test     = "StringNotLike"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/priyanshu302403"]
    }
  }

  statement {
    sid    = "ProtectStateAndAudit"
    effect = "Deny"
    actions = [
      "s3:DeleteBucket",
      "s3:PutBucketPolicy",
      "s3:DeleteBucketPolicy",
      "dynamodb:DeleteTable",
      "cloudtrail:StopLogging",
      "cloudtrail:DeleteTrail",
      "cloudtrail:UpdateTrail",
    ]
    resources = [
      "arn:aws:s3:::pb-dev-state-bucket",
      "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/*",
      "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*",
    ]
  }

  statement {
    sid    = "DenyRoleChainingAndAccountOrAuditChanges"
    effect = "Deny"
    actions = [
      "account:*",
      "access-analyzer:Delete*",
      "cloudtrail:DeleteTrail",
      "cloudtrail:PutEventSelectors",
      "cloudtrail:StopLogging",
      "cloudtrail:UpdateTrail",
      "config:Delete*",
      "config:Stop*",
      "guardduty:*",
      "organizations:*",
      "sts:AssumeRole",
      "sts:AssumeRoleWithSAML",
      "sts:AssumeRoleWithWebIdentity",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "app_permissions_boundary" {
  name        = "app-permissions-boundary"
  description = "Allow-list permissions boundary shared by Terraform-managed workload roles"
  policy      = data.aws_iam_policy_document.app_permissions_boundary.json
}
