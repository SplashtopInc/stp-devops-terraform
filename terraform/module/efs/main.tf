module "efs" {
  source  = "cloudposse/efs/aws"
  version = "0.32.4"

  region  = var.region
  vpc_id  = var.vpc_id
  subnets = var.private_subnet_ids
  // name    = sonarqube

  access_points = {
    "data" = {
      posix_user = {
        gid            = "1001"
        uid            = "5000"
        secondary_gids = "1002,1003"
      }
      creation_info = {
        gid         = "1001"
        uid         = "5000"
        permissions = "0755"
      }
    }
    "data2" = {
      posix_user = {
        gid            = "2001"
        uid            = "6000"
        secondary_gids = null
      }
      creation_info = {
        gid         = "123"
        uid         = "222"
        permissions = "0555"
      }
    }
  }

  additional_security_group_rules = [
    {
      type        = "ingress"
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr_block
      // source_security_group_id = var.vpc_security_groups
      // source_security_group_id = element(var.vpc_security_groups, 0)
      description = "Allow ingress traffic to EFS from trusted Security Groups"
    }
  ]

  transition_to_ia = ["AFTER_30_DAYS"]

  security_group_create_before_destroy = false

  context = module.this.context
}