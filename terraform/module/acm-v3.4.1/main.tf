locals {
  # Use existing (via data source) or create new zone (will fail validation, if zone is not reachable)
  use_existing_route53_zone = var.use_existing_route53_zone

  domain = var.domain_name

  # Removing trailing dot from domain - just to be sure :)
  domain_name       = trimsuffix(local.domain, ".")
  route53_zone_name = trimprefix(local.domain, "*.")
}

data "aws_route53_zone" "this" {
  count = local.use_existing_route53_zone ? 1 : 0

  name         = local.route53_zone_name
  private_zone = false
}

resource "aws_route53_zone" "this" {
  count = !local.use_existing_route53_zone ? 1 : 0
  name  = local.route53_zone_name
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.4.1"

  domain_name = local.domain_name
  zone_id     = coalescelist(data.aws_route53_zone.this.*.zone_id, aws_route53_zone.this.*.zone_id)[0]

  subject_alternative_names = var.subject_alternative_names

  wait_for_validation = var.wait_for_validation

  tags = {
    Name        = local.route53_zone_name
    Project     = var.project
    Environment = var.environment
  }
}