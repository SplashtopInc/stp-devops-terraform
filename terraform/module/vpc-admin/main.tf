### VPC ###
module "vpc-admin" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  create_vpc      = var.create_vpc
  name            = var.name
  cidr            = var.vpc_admin_cidr
  azs             = slice(data.aws_availability_zones.available.names, var.vpc_admin_az_start, var.vpc_admin_az_end)
  private_subnets = var.vpc_admin_pri_subnets
  public_subnets  = var.vpc_admin_pub_subnets

  # One NAT Gateway per subnet (default behavior)
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  # Fixed EIP for NAT Gateway
  reuse_nat_ips       = var.vpc_admin_reuse_nat_ips
  # for allocate EIPs manually
  external_nat_ip_ids = var.vpc_admin_reuse_nat_ips ? var.vpc_admin_nat_eip_ids : []

  # VPC configurations
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_ipv6          = false

  # Auto-assign public IP on launch, default is "true"
  #map_public_ip_on_launch = false

  vpc_tags = {
    Name        = "${var.name}-${var.region}"
    Project     = var.project
    Environment = var.environment
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

### (prod) Whitelist Security Group for office IPs ###
resource "aws_security_group" "stp-office-ip-whitelist" {
  count = var.create_vpc ? 1 : 0
  # checkov:skip=CKV2_AWS_5: WILL ATTACH TO ALB IN HELM
  name        = "stp-office-ip-whitelist"
  description = "Whitelist IPs of offices for PRODUCTION"
  vpc_id      = module.vpc-admin.vpc_id

  dynamic "ingress" {
    for_each = var.sg_whitelist_ips_office_production
    content {
      description = ingress.value.desc
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "ingress" {
    for_each = var.sg_whitelist_ips_office_production
    content {
      description = ingress.value.desc
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "egress" {
    for_each = var.sg_whitelist_ips_office_production
    content {
      description = egress.value.desc
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  tags = {
    Name = "stp-office-ip-whitelist"
  }
}

### (non-prod) Whitelist Security Group for office IPs ###
resource "aws_security_group" "stp-ip-whitelist-office-nonprod" {
  # checkov:skip=CKV2_AWS_5: WILL ATTACH TO ALB IN HELM
  count       = var.create_vpc ? 1 : 0
  name        = "stp-ip-whitelist-office-nonprod"
  description = "Whitelist IPs of offices for non-production"
  vpc_id      = module.vpc-admin.vpc_id

  dynamic "ingress" {
    for_each = var.sg_whitelist_ips_office_nonprod_http
    content {
      description = ingress.value.desc
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "ingress" {
    for_each = var.sg_whitelist_ips_office_nonprod_https
    content {
      description = ingress.value.desc
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "egress" {
    for_each = var.sg_whitelist_ips_office_nonprod_http
    content {
      description = egress.value.desc
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  dynamic "egress" {
    for_each = var.sg_whitelist_ips_office_nonprod_https
    content {
      description = egress.value.desc
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  tags = {
    Name = "stp-ip-whitelist-office-nonprod"
  }
}
### (non-prod) Whitelist Security Group for outside IPs ###
resource "aws_security_group" "stp-ip-whitelist-outside-nonprod" {
  # checkov:skip=CKV2_AWS_5: WILL ATTACH TO ALB IN HELM
  count       = var.create_vpc ? 1 : 0
  name        = "stp-ip-whitelist-outside-nonprod"
  description = "Whitelist IPs of outside for non-production"
  vpc_id      = module.vpc-admin.vpc_id

  dynamic "ingress" {
    for_each = var.sg_whitelist_ips_outside_nonprod_https
    content {
      description = ingress.value.desc
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "egress" {
    for_each = var.sg_whitelist_ips_outside_nonprod_https
    content {
      description = egress.value.desc
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  tags = {
    Name = "stp-ip-whitelist-outside-nonprod"
  }
}
