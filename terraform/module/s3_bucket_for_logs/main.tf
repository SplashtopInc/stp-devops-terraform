module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  create_bucket = var.create_bucket
  bucket        = var.bucket
  acl           = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true # Required for ALB logs
  attach_lb_log_delivery_policy  = true # Required for ALB/NLB logs
  # attach_deny_insecure_transport_policy = true # Controls if S3 bucket should have deny non-SSL transport policy attached
  # attach_require_latest_tls_policy      = true # Controls if S3 bucket should require the latest version of TLS


  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    status     = true
    mfa_delete = false
  }
}
