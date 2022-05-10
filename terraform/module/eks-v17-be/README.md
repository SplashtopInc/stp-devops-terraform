<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks-be"></a> [eks-be](#module\_eks-be) | terraform-aws-modules/eks/aws | 17.22.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.allow_firehose_sqs_s3_sns_r53_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_load_balancer_controller_beapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.allow_firehose_sqs_s3_sns_r53_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_load_balancer_controller_beapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.beapp_cloudwatchagent_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_ami.beapp_node_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.bottlerocket_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks-be](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks-be](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_subnet_ids.stp-vpc-pub-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.stp-vpc-pub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `string` | `""` | no |
| <a name="input_app_service"></a> [app\_service](#input\_app\_service) | ## Services name ### | `string` | `"app"` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | AWS account name for SQS naming prefix (for temporary) | `string` | `""` | no |
| <a name="input_be_api_bottlerocket_labels"></a> [be\_api\_bottlerocket\_labels](#input\_be\_api\_bottlerocket\_labels) | kubelet labels arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_api_bottlerocket_taints"></a> [be\_api\_bottlerocket\_taints](#input\_be\_api\_bottlerocket\_taints) | kubelet taints arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_api_desired_size"></a> [be\_api\_desired\_size](#input\_be\_api\_desired\_size) | n/a | `number` | `3` | no |
| <a name="input_be_api_instance_types"></a> [be\_api\_instance\_types](#input\_be\_api\_instance\_types) | BE App - api | `list(string)` | <pre>[<br>  "t3a.large",<br>  "t3.large",<br>  "t2.large",<br>  "m5a.large",<br>  "m5.large"<br>]</pre> | no |
| <a name="input_be_api_max_size"></a> [be\_api\_max\_size](#input\_be\_api\_max\_size) | n/a | `number` | `5` | no |
| <a name="input_be_api_min_size"></a> [be\_api\_min\_size](#input\_be\_api\_min\_size) | n/a | `number` | `3` | no |
| <a name="input_be_api_on_demand_percentage"></a> [be\_api\_on\_demand\_percentage](#input\_be\_api\_on\_demand\_percentage) | n/a | `number` | `100` | no |
| <a name="input_be_api_on_demand_size"></a> [be\_api\_on\_demand\_size](#input\_be\_api\_on\_demand\_size) | n/a | `number` | `3` | no |
| <a name="input_be_devops_bottlerocket_labels"></a> [be\_devops\_bottlerocket\_labels](#input\_be\_devops\_bottlerocket\_labels) | kubelet labels arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_devops_bottlerocket_taints"></a> [be\_devops\_bottlerocket\_taints](#input\_be\_devops\_bottlerocket\_taints) | kubelet taints arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_devops_desired_size"></a> [be\_devops\_desired\_size](#input\_be\_devops\_desired\_size) | n/a | `number` | `3` | no |
| <a name="input_be_devops_instance_types"></a> [be\_devops\_instance\_types](#input\_be\_devops\_instance\_types) | BE App - devops | `list(string)` | `[]` | no |
| <a name="input_be_devops_max_size"></a> [be\_devops\_max\_size](#input\_be\_devops\_max\_size) | n/a | `number` | `5` | no |
| <a name="input_be_devops_min_size"></a> [be\_devops\_min\_size](#input\_be\_devops\_min\_size) | n/a | `number` | `3` | no |
| <a name="input_be_devops_on_demand_percentage"></a> [be\_devops\_on\_demand\_percentage](#input\_be\_devops\_on\_demand\_percentage) | n/a | `number` | `100` | no |
| <a name="input_be_devops_on_demand_size"></a> [be\_devops\_on\_demand\_size](#input\_be\_devops\_on\_demand\_size) | n/a | `number` | `3` | no |
| <a name="input_be_eks_bottlerocket_enabled"></a> [be\_eks\_bottlerocket\_enabled](#input\_be\_eks\_bottlerocket\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_be_eks_enabled"></a> [be\_eks\_enabled](#input\_be\_eks\_enabled) | ## Work groups scaling ### Instance types of maximum pods list: https://github.com/awslabs/amazon-eks-ami/blob/master/files/eni-max-pods.txt BE App EKS | `bool` | `true` | no |
| <a name="input_be_kubelet_args_api"></a> [be\_kubelet\_args\_api](#input\_be\_kubelet\_args\_api) | kubelet arguments for backend api work group | `list(string)` | `[]` | no |
| <a name="input_be_kubelet_args_devops"></a> [be\_kubelet\_args\_devops](#input\_be\_kubelet\_args\_devops) | kubelet arguments for backend devops work group | `list(string)` | `[]` | no |
| <a name="input_be_kubelet_args_my"></a> [be\_kubelet\_args\_my](#input\_be\_kubelet\_args\_my) | kubelet arguments for backend my work group | `list(string)` | `[]` | no |
| <a name="input_be_my_bottlerocket_labels"></a> [be\_my\_bottlerocket\_labels](#input\_be\_my\_bottlerocket\_labels) | kubelet labels arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_my_bottlerocket_taints"></a> [be\_my\_bottlerocket\_taints](#input\_be\_my\_bottlerocket\_taints) | kubelet taints arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_my_desired_size"></a> [be\_my\_desired\_size](#input\_be\_my\_desired\_size) | n/a | `number` | `3` | no |
| <a name="input_be_my_instance_types"></a> [be\_my\_instance\_types](#input\_be\_my\_instance\_types) | BE App - my | `list(string)` | `[]` | no |
| <a name="input_be_my_max_size"></a> [be\_my\_max\_size](#input\_be\_my\_max\_size) | n/a | `number` | `5` | no |
| <a name="input_be_my_min_size"></a> [be\_my\_min\_size](#input\_be\_my\_min\_size) | n/a | `number` | `3` | no |
| <a name="input_be_my_on_demand_percentage"></a> [be\_my\_on\_demand\_percentage](#input\_be\_my\_on\_demand\_percentage) | n/a | `number` | `100` | no |
| <a name="input_be_my_on_demand_size"></a> [be\_my\_on\_demand\_size](#input\_be\_my\_on\_demand\_size) | n/a | `number` | `3` | no |
| <a name="input_bottlerocket_worker_ami_owner_id"></a> [bottlerocket\_worker\_ami\_owner\_id](#input\_bottlerocket\_worker\_ami\_owner\_id) | n/a | `string` | `"amazon"` | no |
| <a name="input_certArnApi"></a> [certArnApi](#input\_certArnApi) | SSL cert ARN for API tier, e.g. *.api.example.com | `string` | `""` | no |
| <a name="input_certArnDomain"></a> [certArnDomain](#input\_certArnDomain) | SSL cert ARN for tier one domain, e.g. *.example.com | `string` | `""` | no |
| <a name="input_cloudbuild_service"></a> [cloudbuild\_service](#input\_cloudbuild\_service) | n/a | `string` | `"cloudbuild"` | no |
| <a name="input_cloudfront_dist_id_g2"></a> [cloudfront\_dist\_id\_g2](#input\_cloudfront\_dist\_id\_g2) | ## CloudFront Distributions ### | `string` | `"XXXXXXX"` | no |
| <a name="input_cloudfront_dist_id_g3"></a> [cloudfront\_dist\_id\_g3](#input\_cloudfront\_dist\_id\_g3) | n/a | `string` | `"XXXXXXX"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | ## Site information ### | `string` | `"splashtop.de"` | no |
| <a name="input_eks_api_whitelist"></a> [eks\_api\_whitelist](#input\_eks\_api\_whitelist) | IP whitelist for EKS API public access | `list(string)` | `[]` | no |
| <a name="input_eks_bottlerocket_enabled"></a> [eks\_bottlerocket\_enabled](#input\_eks\_bottlerocket\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | ## EKS ### Version | `string` | `"1.21"` | no |
| <a name="input_eks_log_retention"></a> [eks\_log\_retention](#input\_eks\_log\_retention) | Log retention | `number` | `7` | no |
| <a name="input_eks_spot_enabled"></a> [eks\_spot\_enabled](#input\_eks\_spot\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_enable_admin_container"></a> [enable\_admin\_container](#input\_enable\_admin\_container) | Enable/disable admin container | `bool` | `false` | no |
| <a name="input_enable_control_container"></a> [enable\_control\_container](#input\_enable\_control\_container) | Enable/disable control container | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_hardened_worker_ami_linux"></a> [hardened\_worker\_ami\_linux](#input\_hardened\_worker\_ami\_linux) | n/a | `string` | `"*GoldenAMIBase-1.0-amazon-eks-node-1.21-1"` | no |
| <a name="input_hardened_worker_ami_owner_id"></a> [hardened\_worker\_ami\_owner\_id](#input\_hardened\_worker\_ami\_owner\_id) | Customized AMI for EKS work node | `string` | `""` | no |
| <a name="input_map_accounts"></a> [map\_accounts](#input\_map\_accounts) | Additional AWS account numbers to add to the aws-auth configmap. | `list(string)` | <pre>[<br>  "777777777777",<br>  "888888888888"<br>]</pre> | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "rolearn": "arn:aws:iam::66666666666:role/role1",<br>    "username": "role1"<br>  }<br>]</pre> | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "userarn": "arn:aws:iam::66666666666:user/user1",<br>    "username": "user1"<br>  },<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "userarn": "arn:aws:iam::66666666666:user/user2",<br>    "username": "user2"<br>  }<br>]</pre> | no |
| <a name="input_mymail_service"></a> [mymail\_service](#input\_mymail\_service) | n/a | `string` | `"my-mail"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | ## System ### AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_relayfe_service"></a> [relayfe\_service](#input\_relayfe\_service) | n/a | `string` | `"relay-fe-17"` | no |
| <a name="input_relayrs_service"></a> [relayrs\_service](#input\_relayrs\_service) | n/a | `string` | `"relay-rs-17"` | no |
| <a name="input_ssh_keypair"></a> [ssh\_keypair](#input\_ssh\_keypair) | SSH key name for EC2 instance | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | vpc module outputs the pub-private-subnet ID under the name subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc module outputs the ID under the name vpc\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_cluster_name"></a> [app\_cluster\_name](#output\_app\_cluster\_name) | n/a |
| <a name="output_cluster_name_suffix"></a> [cluster\_name\_suffix](#output\_cluster\_name\_suffix) | n/a |
| <a name="output_eks-be"></a> [eks-be](#output\_eks-be) | ######## Output ######## |
<!-- END_TF_DOCS -->