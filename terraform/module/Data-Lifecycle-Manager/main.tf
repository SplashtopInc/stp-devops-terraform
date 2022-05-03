resource "aws_iam_role" "dlm_lifecycle_role" {
  name = "dlm-lifecycle-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_role_policy" "dlm_lifecycle" {
  name = "dlm-lifecycle-policy"
  role = aws_iam_role.dlm_lifecycle_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
        "Effect": "Allow",
        "Action": [
            "ec2:CreateSnapshot",
            "ec2:CreateSnapshots",
            "ec2:DeleteSnapshot",
            "ec2:DescribeInstances",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "ec2:CreateTags"
        ],
        "Resource": "arn:aws:ec2:*::snapshot/*"
      }
  ]
}
EOF
}

resource "aws_dlm_lifecycle_policy" "example" {
  description        = "DLM lifecycle policy"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = var.state
  tags = {
    Name = "ebs-snapshot"
  }
  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "1 weeks of daily snapshots"

      create_rule {
        interval      = var.interval
        interval_unit = var.interval_unit
        times         = var.times
      }

      retain_rule {
        count = var.keep_days
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = false
    }

    target_tags = var.target_tags
  }
}