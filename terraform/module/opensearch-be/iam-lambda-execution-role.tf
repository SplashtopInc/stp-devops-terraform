### Execution role for Premium Inventory Lambda function ###
resource "aws_iam_role" "premium_inventory_lambda_execution_role" {
  count       = var.enabled ? 1 : 0
  description = "Premium Inventory Lambda Execution Role"
  name        = "premium-inventory-lambda-execution-role-${local.elasticache_cluster_domain}"
  path        = "/"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowAssumeRole4Lambda",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

### Allow S3 for Premium Inventory Lambda function ###
resource "aws_iam_policy" "premium_inventory_lambda_execution_role_policy" {
  count       = var.enabled ? 1 : 0
  description = "Allow S3 for Premium Inventory Lambda"
  name        = "premium-inventory-lambda-execution-role-policy-${local.elasticache_cluster_domain}"
  path        = "/"
  #tfsec:ignore:aws-iam-no-policy-wildcards
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ListObjectsInBucket",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "*"
      },
      {
        "Sid" : "AllObjectActions",
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : [
          "arn:aws:s3:::*inventory*"
        ]
      }
    ]
  })
}

### Attach S3 policy to Lambda execution role ###
resource "aws_iam_role_policy_attachment" "attach_s3_policy_to_premium_inventory_lambda_role" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.premium_inventory_lambda_execution_role[0].name
  policy_arn = aws_iam_policy.premium_inventory_lambda_execution_role_policy[0].arn
}

### Attach AWSLambdaBasicExecutionRole to Lambda execution role ###
resource "aws_iam_role_policy_attachment" "attach_lambda_execution_to_premium_inventory_lambda_role" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.premium_inventory_lambda_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
