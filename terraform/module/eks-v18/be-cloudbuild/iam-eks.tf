### Attach ALB Ingress policy to EC2 instance role of Backend EKS worker node ###
#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "aws_load_balancer_controller_cb" {
  #checkov:skip=CKV_AWS_111:sikp
  #checkov:skip=CKV_AWS_109:sikp
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values = [
        "elasticloadbalancing.amazonaws.com"
      ]
    }
  }
  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeTags",
      "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "cognito-idp:DescribeUserPoolClient",
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "iam:ListServerCertificates",
      "iam:GetServerCertificate",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "4"
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${module.eks.cluster_id}"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "5"
    effect = "Allow"
    actions = [
      "ec2:CreateSecurityGroup"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "6"
    effect = "Allow"
    actions = [
      "ec2:CreateTags"
    ]
    resources = ["arn:aws:ec2:*:*:security-group/*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values = [
        "CreateSecurityGroup"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "7"
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]
    resources = ["arn:aws:ec2:*:*:security-group/*"]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values = [
        "true"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "8"
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "9"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "10"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteRule"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "11"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags"
    ]
    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
    ]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values = [
        "true"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "12"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags"
    ]
    resources = [
      "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
    ]
  }
  statement {
    sid    = "13"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values = [
        "false"
      ]
    }
  }
  statement {
    sid    = "14"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]
    resources = ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]
  }
  statement {
    sid    = "15"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:SetWebAcl",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:ModifyRule"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "aws_load_balancer_controller_cb" {
  name        = "${local.name}-aws_load_balancer_controller_cb"
  path        = "/"
  description = "Allow ALB Ingress for CloudBuild"
  policy      = data.aws_iam_policy_document.aws_load_balancer_controller_cb.json
}

### Attach Kinesis, SQS, S3, SNS, External-DNS and AutoScaling policy to EC2 instance role of Backend EKS worker node ###
#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "allow_firehose_r53_autoscaling_s3_sns" {
  #checkov:skip=CKV_AWS_111:sikp
  statement {
    sid    = "Allow2AccessKinesisStream4CloudBuild"
    effect = "Allow"
    actions = [
      "firehose:DeleteDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
      "firehose:UpdateDestination"
    ]
    resources = ["arn:aws:firehose:*:*:deliverystream/*stream-cloudbuilder-*"]
  }
  statement {
    sid    = "AllowR53Update"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }
  statement {
    sid    = "AllowR53List"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowAutoScaling"
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowArgoCD2Download"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = ["arn:aws:s3:::stp-devops-helm*"]
  }
  statement {
    sid    = "AllowPublishSNS"
    effect = "Allow"
    actions = [
      "sns:Publish"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "allow_firehose_r53_autoscaling_s3_sns" {
  name        = "${local.name}-allow_firehose_r53_autoscaling_s3_sns"
  path        = "/"
  policy      = data.aws_iam_policy_document.allow_firehose_r53_autoscaling_s3_sns.json
  description = "Allow External-DN to modify Route53 for CloudBuild and AutoScaling"
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "elasticfilesystem_access" {
  #checkov:skip=CKV_AWS_111:sikp
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "elasticfilesystem:CreateAccessPoint"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"

      values = [
        "true"
      ]
    }
  }
  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "elasticfilesystem:DeleteAccessPoint"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"

      values = [
        "true"
      ]
    }
  }
}
resource "aws_iam_policy" "elasticfilesystem_access" {
  name   = "${local.name}-elasticfilesystem_access"
  path   = "/"
  policy = data.aws_iam_policy_document.elasticfilesystem_access.json
}

### attach policy

resource "aws_iam_role_policy_attachment" "attach-2-eks-worker-role-albingress" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.aws_load_balancer_controller_cb.arn
  depends_on = [module.eks]
}

resource "aws_iam_role_policy_attachment" "attach-2-eks-worker-role-externaldns" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.allow_firehose_r53_autoscaling_s3_sns.arn
  depends_on = [module.eks]
}

resource "aws_iam_role_policy_attachment" "elasticfilesystem_access" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.elasticfilesystem_access.arn
  depends_on = [module.eks]
}

### Attach CloudWatchAgent privilege for management ###
resource "aws_iam_role_policy_attachment" "attach-aws-cloudwatchagent-policy" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  depends_on = [module.eks]
}