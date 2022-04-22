### Execution role for Premium Inventory Lambda function ###
resource "aws_iam_role" "premium_inventory_lambda_execution_role" {
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

### Attach AWSLambdaBasicExecutionRole to Lambda execution role ###
resource "aws_iam_role_policy_attachment" "attach_lambda_execution_to_premium_inventory_lambda_role" {
  role       = aws_iam_role.premium_inventory_lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

