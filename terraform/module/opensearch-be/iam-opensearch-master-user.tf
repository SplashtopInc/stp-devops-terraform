### Role for Opensearch master user ###
resource "aws_iam_role" "premium_inventory_opensearch_master_user" {
  description = "Opensearch Master Role"
  name        = "premium-inventory-opensearch-master-user-${local.elasticache_cluster_domain}"
  path        = "/"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "OnlyAllowSpecificRolesToAssumeThisRole",
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Condition" : {
          "ArnEquals" : {
            "aws:PrincipalArn" : [
              "${aws_iam_role.premium_inventory_lambda_execution_role.arn}",
              "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/be-app-*"
            ]
          }
        }
      }
    ]
  })
}

### Attach AmazonOpenSearchServiceFullAccess policy to Opensearch master user ###
resource "aws_iam_role_policy_attachment" "attach_opensearch_fullaccess_policy_to_premium_inventory_opensearch_master_user" {
  role       = aws_iam_role.premium_inventory_opensearch_master_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonOpenSearchServiceFullAccess"
}

### Move here because the "Master User" recousre created in here ###
### Allow AssumeRole & S3 for Premium Inventory Lambda function ###
resource "aws_iam_policy" "premium_inventory_lambda_execution_role_policy" {
  description = "Allow AssumeRole & S3 for Premium Inventory Lambda"
  name        = "premium-inventory-lambda-execution-role-policy-${local.elasticache_cluster_domain}"
  path        = "/"
  #tfsec:ignore:aws-iam-no-policy-wildcards
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAssumeRole2OpensearchMasterUser",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "${aws_iam_role.premium_inventory_opensearch_master_user.arn}"
        },
        {
            "Sid": "ListObjectsInBucket",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "*"
        },
        {
            "Sid": "AllObjectActions",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::*inventory*"
            ]
        }
    ]
}
EOF
}

### Attach S3 policy to Lambda execution role ###
resource "aws_iam_role_policy_attachment" "attach_s3_policy_to_premium_inventory_lambda_role" {
  role       = aws_iam_role.premium_inventory_lambda_execution_role.name
  policy_arn = aws_iam_policy.premium_inventory_lambda_execution_role_policy.arn
}
