<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks-bottlerocket"></a> [eks-bottlerocket](#module\_eks-bottlerocket) | terraform-aws-modules/eks/aws | 17.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.autoscaler_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.beapp_helmrepo_s3bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cloudbuild_s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.elasticfilesystem_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.kinesis_firehose_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.autoscaler_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.elasticfilesystem_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_ami.bottlerocket_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks-bottlerocket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks-bottlerocket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `string` | `""` | no |
| <a name="input_app_service"></a> [app\_service](#input\_app\_service) | ## Services name ### | `string` | `"gh-bottlerocket"` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | AWS account name for SQS naming prefix (for temporary) | `string` | `""` | no |
| <a name="input_certArnApi"></a> [certArnApi](#input\_certArnApi) | n/a | `string` | `"arn:aws:acm:eu-central-1:964543278669:certificate/71803539-520b-4194-aaba-96c35783dfba"` | no |
| <a name="input_certArnDomain"></a> [certArnDomain](#input\_certArnDomain) | ## Certificates ### | `string` | `"arn:aws:acm:eu-central-1:964543278669:certificate/22e6bdda-e82a-467a-baec-0c056972fb26"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | ## Site information ### | `string` | `"splashtop.de"` | no |
| <a name="input_eks_bottlerocket_enabled"></a> [eks\_bottlerocket\_enabled](#input\_eks\_bottlerocket\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_eks_log_retention"></a> [eks\_log\_retention](#input\_eks\_log\_retention) | Log retention | `number` | `7` | no |
| <a name="input_eks_spot_enabled"></a> [eks\_spot\_enabled](#input\_eks\_spot\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_enable_admin_container"></a> [enable\_admin\_container](#input\_enable\_admin\_container) | Enable/disable admin container | `bool` | `false` | no |
| <a name="input_enable_control_container"></a> [enable\_control\_container](#input\_enable\_control\_container) | Enable/disable control container | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | k8s cluster version | `string` | `"1.20"` | no |
| <a name="input_map_accounts"></a> [map\_accounts](#input\_map\_accounts) | Additional AWS account numbers to add to the aws-auth configmap. | `list(string)` | <pre>[<br>  "777777777777",<br>  "888888888888"<br>]</pre> | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "rolearn": "arn:aws:iam::66666666666:role/role1",<br>    "username": "role1"<br>  }<br>]</pre> | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "userarn": "arn:aws:iam::66666666666:user/user1",<br>    "username": "user1"<br>  },<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "userarn": "arn:aws:iam::66666666666:user/user2",<br>    "username": "user2"<br>  }<br>]</pre> | no |
| <a name="input_node_desired_size"></a> [node\_desired\_size](#input\_node\_desired\_size) | n/a | `number` | `3` | no |
| <a name="input_node_instance_type"></a> [node\_instance\_type](#input\_node\_instance\_type) | ## Work groups scaling ### Instance types of maximum pods list: https://github.com/awslabs/amazon-eks-ami/blob/master/files/eni-max-pods.txt | `string` | `"t3a.xlarge"` | no |
| <a name="input_node_max_size"></a> [node\_max\_size](#input\_node\_max\_size) | n/a | `number` | `5` | no |
| <a name="input_node_min_size"></a> [node\_min\_size](#input\_node\_min\_size) | n/a | `number` | `3` | no |
| <a name="input_node_on_demand_size"></a> [node\_on\_demand\_size](#input\_node\_on\_demand\_size) | n/a | `number` | `0` | no |
| <a name="input_override_instance_types"></a> [override\_instance\_types](#input\_override\_instance\_types) | n/a | `list(string)` | <pre>[<br>  "t3a.xlarge",<br>  "t3.xlarge",<br>  "t2.xlarge",<br>  "m5a.xlarge",<br>  "m5.xlarge"<br>]</pre> | no |
| <a name="input_profile"></a> [profile](#input\_profile) | ## System ### AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_sg_whitelist_ips"></a> [sg\_whitelist\_ips](#input\_sg\_whitelist\_ips) | ## SG whitelist ### | `list(string)` | <pre>[<br>  "74.203.89.92/32",<br>  "104.128.103.242/32",<br>  "75.61.103.188/32",<br>  "50.193.44.33/32",<br>  "122.224.111.100/32",<br>  "211.23.144.132/32",<br>  "61.31.169.172/32"<br>]</pre> | no |
| <a name="input_sonarqube_instance_types"></a> [sonarqube\_instance\_types](#input\_sonarqube\_instance\_types) | n/a | `list(string)` | <pre>[<br>  "m5.large"<br>]</pre> | no |
| <a name="input_ssh_keypair"></a> [ssh\_keypair](#input\_ssh\_keypair) | n/a | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | vpc module outputs the pub-private-subnet ID under the name subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc module outputs the ID under the name vpc\_id | `string` | `""` | no |
| <a name="input_worker_ami_linux"></a> [worker\_ami\_linux](#input\_worker\_ami\_linux) | n/a | `string` | `"*copied from GoldenAMIBase-1.0-amazon-eks-node-1.16-noSELINUX-HFSPLUS-3"` | no |
| <a name="input_worker_ami_owner_id"></a> [worker\_ami\_owner\_id](#input\_worker\_ami\_owner\_id) | Customized AMI for EKS work node | `string` | `"867359575977"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks-bottlerocket"></a> [eks-bottlerocket](#output\_eks-bottlerocket) | n/a |
| <a name="output_eks-bottlerocket-cluster-ca"></a> [eks-bottlerocket-cluster-ca](#output\_eks-bottlerocket-cluster-ca) | n/a |
| <a name="output_eks-bottlerocket-cluster-ca-data"></a> [eks-bottlerocket-cluster-ca-data](#output\_eks-bottlerocket-cluster-ca-data) | n/a |
| <a name="output_eks-bottlerocket-cluster-endpoint"></a> [eks-bottlerocket-cluster-endpoint](#output\_eks-bottlerocket-cluster-endpoint) | n/a |
| <a name="output_eks-bottlerocket-cluster-id"></a> [eks-bottlerocket-cluster-id](#output\_eks-bottlerocket-cluster-id) | ######## Output ######## |
| <a name="output_eks-bottlerocket-kubeconfig"></a> [eks-bottlerocket-kubeconfig](#output\_eks-bottlerocket-kubeconfig) | n/a |
<!-- END_TF_DOCS -->