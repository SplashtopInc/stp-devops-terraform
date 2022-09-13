### Security Group for Elasticsearch
resource "aws_security_group" "elasticsearch_sg" {
  #ts:skip=AC_AWS_0322 already add slow logs
  #bridgecrew:skip=CKV2_AWS_5:Attach in other place
  description = "Security Group - ${local.elasticache_cluster_domain}"
  name_prefix = "${local.elasticache_cluster_domain}-sg"
  vpc_id      = data.aws_vpc.stp_vpc_db.id

  # Allow internal
  ingress {
    description = "Allow access from local LAN for OpenSearch"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16"
    ]
  }

  egress {
    description = "Allow all to local LAN for OpenSearch"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16"
    ]
  }

  tags = {
    Name = "${local.elasticache_cluster_domain}-sg"
  }
}

### Create a new VPC security group for Lambda function
resource "aws_security_group" "lambda_premium_inventory_sg" {
  #bridgecrew:skip=CKV2_AWS_5:Attach in other place
  name        = "lambda-premium-inventory-sg-${var.short_region}"
  description = "Security Group for Lambda Premium Inventory"
  vpc_id      = data.aws_vpc.stp-vpc-pub.id

  ingress {
    description = "Only allow self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description = "Allow all from self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
  }
}


