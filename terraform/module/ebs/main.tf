data "aws_instance" "this" {
  filter {
    name   = "tag:Name"
    values = var.eks_instance_name
  }
}

resource "aws_ebs_volume" "this" {
  #checkov:skip=CKV2_AWS_9:We use the dlm for daily snapshot
  #checkov:skip=CKV_AWS_189:pass true to encrypted value
  #ts:skip=AWS.EBS.EKM.Medium.0682 pass true to encrypted value
  availability_zone = var.availability_zone != "" ? var.availability_zone : data.aws_instance.this.availability_zone
  size              = var.size
  type              = var.type
  encrypted         = var.encrypted
  #tfsec:ignore:aws-ebs-encryption-customer-key
  kms_key_id = var.kms_key_id
  tags = merge(
    {
      "Name" = format("%s", var.ebs_name)
    },
    var.ebs_tags,
  )
}