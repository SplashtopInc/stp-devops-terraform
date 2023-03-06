### Attach ALB Ingress policy to EC2 instance role of Backend EKS worker node ###
### source ref: https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.0/docs/install/iam_policy.json
## IAM policy for the AWS Load Balancer Controller
#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "alb_ingress" {
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
  statement {
    sid    = "16"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.aws_account_name}-log-elb-${var.region}"
    ]
  }
}
resource "aws_iam_policy" "alb_ingress" {
  count  = var.create ? 1 : 0
  name   = "${local.name}-ALB_Controller_IAMPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.alb_ingress.json
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "ecr_access" {
  #checkov:skip=CKV_AWS_111:sikp
  statement {
    sid    = "AllowPushPull"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:UploadLayerPart",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "ecr_access" {
  count  = var.create ? 1 : 0
  name   = "${local.name}-ecr_access"
  path   = "/"
  policy = data.aws_iam_policy_document.ecr_access.json
}

### Attach Kinesis, SQS, S3, SNS, External-DNS and AutoScaling policy to EC2 instance role of Backend EKS worker node ###
#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "allow_firehose_sqs_s3_sns_r53_autoscaling" {
  #checkov:skip=CKV_AWS_111:sikp
  statement {
    sid    = "Allow2AccessKinesisStream4Backend"
    effect = "Allow"
    actions = [
      "firehose:DeleteDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
      "firehose:UpdateDestination"
    ]
    resources = ["arn:aws:firehose:*:*:deliverystream/*stream-maillog*"]
  }
  statement {
    sid    = "AllowFullAccess2SQS"
    effect = "Allow"
    actions = [
      "sqs:*"
    ]
    resources = ["arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    sid    = "AllObjectActions"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::stp-devops-helm*",
      "arn:aws:s3:::${var.aws_account_name}-splashtop-chat-${var.region}*",
      "arn:aws:s3:::${var.aws_account_name}-splashtop-cid-${var.region}*",
      "arn:aws:s3:::${var.aws_account_name}-splashtop-cloudbuild*",
      "arn:aws:s3:::${var.aws_account_name}-splashtop-premium*",
      "arn:aws:s3:::${var.aws_account_name}-splashtop-team-assets-${var.region}*",
      "arn:aws:s3:::${var.aws_account_name}-splashtop-assets-${var.region}*"
    ]
  }
  statement {
    sid    = "AllowPublishSNS"
    effect = "Allow"
    actions = [
      "sns:Publish"
    ]
    resources = ["*"]
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
    sid    = "AllowCloudFrontInvalidation"
    effect = "Allow"
    actions = [
      "cloudfront:GetInvalidation",
      "cloudfront:CreateInvalidation"
    ]
    resources = [
      "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_dist_id_g2}",
      "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_dist_id_g3}"
    ]
  }
  statement {
    sid    = "AllowAssumeRole2OpensearchMasterUser"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/premium-inventory-opensearch-master-user-es-db-*"
    ]
  }
}
resource "aws_iam_policy" "allow_firehose_sqs_s3_sns_r53_autoscaling" {
  count  = var.create ? 1 : 0
  name   = "${local.name}-allow_firehose_sqs_s3_sns_r53_autoscaling"
  path   = "/"
  policy = data.aws_iam_policy_document.allow_firehose_sqs_s3_sns_r53_autoscaling.json
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
  count  = var.create ? 1 : 0
  name   = "${local.name}-elasticfilesystem_access"
  path   = "/"
  policy = data.aws_iam_policy_document.elasticfilesystem_access.json
}

### attach policy

resource "aws_iam_role_policy_attachment" "alb_ingress" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.alb_ingress[0].arn
  depends_on = [module.eks]
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.ecr_access[0].arn
  depends_on = [module.eks]
}

resource "aws_iam_role_policy_attachment" "allow_firehose_sqs_s3_sns_r53_autoscaling" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.allow_firehose_sqs_s3_sns_r53_autoscaling[0].arn
  depends_on = [module.eks]
}

resource "aws_iam_role_policy_attachment" "elasticfilesystem_access" {
  for_each   = module.eks.self_managed_node_groups
  role       = lookup(each.value, "iam_role_name", "")
  policy_arn = aws_iam_policy.elasticfilesystem_access[0].arn
  depends_on = [module.eks]
}

# create iam for service account
# Create an IAM role. Create a Kubernetes service account named aws-load-balancer-controller in the kube-system namespace for the AWS Load Balancer Controller 
# and annotate the Kubernetes service account with the name of the IAM role.
# ref: https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

## create k8s_aws_lb_controller_trust.json
data "aws_iam_policy_document" "load_balancer_role_trust_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${local.role_numbers}:oidc-provider/${data.aws_eks_cluster.this[0].identity.oidc.issuer}"]
    }
    condition {
      test     = "StringEquals"
      variable = "${data.aws_eks_cluster.this[0].identity.oidc.issuer}:sub"
      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${data.aws_eks_cluster.this[0].identity.oidc.issuer}:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }

  }
  depends_on = [module.eks]
}

## Create an IAM role with policy

resource "aws_iam_role" "aws_eks_lb_controller_role" {
  count              = var.create ? 1 : 0
  name               = "${local.name}-aws_eks_lb_controller_role"
  assume_role_policy = data.aws_iam_policy_document.load_balancer_role_trust_policy.json
  depends_on         = [module.eks]
}

resource "aws_iam_role_policy_attachment" "k8s_aws_lb_controller" {
  count = var.create ? 1 : 0
  role  = aws_iam_role.aws_eks_lb_controller_role[0].name
  ## https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/install/iam_policy.json
  policy_arn = aws_iam_policy.alb_ingress[0].arn
  depends_on = [module.eks]
}