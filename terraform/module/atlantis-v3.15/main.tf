## https://github.com/terraform-aws-modules/terraform-aws-atlantis/blob/master/examples/github-complete/main.tf
locals {
  name   = var.name
  region = var.region
  tags = {
    Owner       = var.project
    Environment = var.environment
  }
  repos = flatten([
    for repo in var.allowed_repo_names :
    ["github.com/${var.github_owner}/${repo}"]
  ])
}

################################################################################
# Supporting Resources
################################################################################

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_elb_service_account" "current" {}

##############################################################
# Atlantis Service
##############################################################
module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "3.15.0"

  name = local.name
  # "Docker image to run Atlantis with. If not specified, official Atlantis image will be used"
  atlantis_image = var.atlantis_image

  # VPC
  cidr            = var.cidr
  azs             = ["${local.region}a", "${local.region}c", "${local.region}d"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # EFS
  enable_ephemeral_storage = var.enable_ephemeral_storage

  # ECS
  ecs_service_platform_version = "LATEST"
  ecs_container_insights       = true
  ecs_task_cpu                 = 512
  ecs_task_memory              = 1024
  container_memory_reservation = 256
  container_cpu                = 512
  container_memory             = 1024

  entrypoint        = var.entrypoint
  command           = var.command
  working_directory = var.working_directory
  docker_labels = {
    "org.opencontainers.image.title"       = "Atlantis"
    "org.opencontainers.image.description" = "A self-hosted golang application that listens for Terraform pull request events via webhooks."
    "org.opencontainers.image.url"         = "https://github.com/runatlantis/atlantis/pkgs/container/atlantis"
  }
  start_timeout = 30
  stop_timeout  = 30

  readonly_root_filesystem = false # atlantis currently mutable access to root filesystem
  ulimits = [{
    name      = "nofile"
    softLimit = 4096
    hardLimit = 16384
  }]

  # DNS (without trailing dot)
  route53_zone_name = var.route53_zone_name
  # ACM
  # "ARN of certificate issued by AWS ACM. If empty, a new ACM certificate will be created and validated using Route53 DNS"
  certificate_arn = var.certificate_arn

  # Trusted roles
  trusted_principals = ["ssm.amazonaws.com"]

  # Atlantis
  atlantis_github_user       = var.atlantis_github_user
  atlantis_github_user_token = var.atlantis_github_user_token
  // atlantis_repo_allowlist    = ["github.com/${var.github_owner}/*"]
  atlantis_repo_allowlist = local.repos

  # ALB access
  alb_ingress_cidr_blocks         = var.alb_ingress_cidr_blocks
  alb_ingress_ipv6_cidr_blocks    = var.alb_ingress_ipv6_cidr_blocks
  alb_logging_enabled             = true
  alb_log_bucket_name             = module.atlantis_access_log_bucket.s3_bucket_id
  alb_log_location_prefix         = "atlantis-alb"
  alb_listener_ssl_policy_default = "ELBSecurityPolicy-TLS-1-2-2017-01"
  alb_drop_invalid_header_fields  = true

  allow_unauthenticated_access = true
  allow_github_webhooks        = true
  allow_repo_config            = true

  tags = local.tags

  custom_environment_variables = var.custom_environment_variables
}
################################################################################
# GitHub Webhooks
################################################################################

module "github_repository_webhook" {
  source = "../github-repository-webhook"

  github_owner = var.github_owner
  github_token = var.atlantis_github_user_token

  // atlantis_repo_allowlist = module.atlantis.atlantis_repo_allowlist
  atlantis_repo_allowlist = var.allowed_repo_names

  webhook_url    = module.atlantis.atlantis_url_events
  webhook_secret = module.atlantis.webhook_secret
}

################################################################################
# ALB Access Log Bucket + Policy
################################################################################
module "atlantis_access_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = "atlantis-access-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  attach_policy = true
  policy        = data.aws_iam_policy_document.atlantis_access_log_bucket_policy.json

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  force_destroy = true

  tags = local.tags

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule = [
    {
      id      = "all"
      enabled = true

      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
          }, {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        days = 30
      }
    },
  ]
}

data "aws_iam_policy_document" "atlantis_access_log_bucket_policy" {
  statement {
    sid     = "LogsLogDeliveryWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    resources = [
      "${module.atlantis_access_log_bucket.s3_bucket_arn}/*/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    principals {
      type = "AWS"
      identifiers = [
        # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions
        data.aws_elb_service_account.current.arn,
      ]
    }
  }

  statement {
    sid     = "AWSLogDeliveryWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    resources = [
      "${module.atlantis_access_log_bucket.s3_bucket_arn}/*/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }
  }

  statement {
    sid     = "AWSLogDeliveryAclCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    resources = [
      module.atlantis_access_log_bucket.s3_bucket_arn
    ]

    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com"
      ]
    }
  }
}
