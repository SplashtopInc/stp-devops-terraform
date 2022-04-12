## Allocate EIPs for NAT Gateways of EKS VPC private subnets ###
resource "aws_eip" "stp-vpc-backend-nat-eip" {
  count = 2

  vpc = true
}

### VPC ###
module "vpc-be" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  name            = var.name
  cidr            = var.vpc_backend_cidr
  azs             = slice(data.aws_availability_zones.available.names, var.vpc_backend_az_start, var.vpc_backend_az_end)
  private_subnets = var.vpc_backend_pri_subnets
  public_subnets  = var.vpc_backend_pub_subnets

  # One NAT Gateway per subnet (default behavior)
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  # Fixed EIP for NAT Gateway
  reuse_nat_ips = var.vpc_backend_reuse_nat_ips
  # for allocate EIPs manually
  external_nat_ip_ids = var.vpc_backend_reuse_nat_ips ? var.vpc_backend_nat_eip_ids : []

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

