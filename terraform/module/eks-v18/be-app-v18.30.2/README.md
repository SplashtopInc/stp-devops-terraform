<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.36.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 18.30.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.allow_firehose_sqs_s3_sns_r53_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.elasticfilesystem_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws-lb-controller-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.allow_firehose_sqs_s3_sns_r53_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws-lb-controller-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.elasticfilesystem_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [null_resource.apply](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_ami.beapp_node_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_firehose_sqs_s3_sns_r53_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elasticfilesystem_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.load-balancer-role-trust-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnets.stp-vpc-pub-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.stp-vpc-pub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `string` | `""` | no |
| <a name="input_app_service"></a> [app\_service](#input\_app\_service) | ## Services name ### | `string` | `"app"` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_attach_cluster_encryption_policy"></a> [attach\_cluster\_encryption\_policy](#input\_attach\_cluster\_encryption\_policy) | Indicates whether or not to attach an additional policy for the cluster IAM role to utilize the encryption key provided | `bool` | `true` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | n/a | `string` | `""` | no |
| <a name="input_aws_assume_role"></a> [aws\_assume\_role](#input\_aws\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_be_api_desired_size"></a> [be\_api\_desired\_size](#input\_be\_api\_desired\_size) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `3` | no |
| <a name="input_be_api_instance_types"></a> [be\_api\_instance\_types](#input\_be\_api\_instance\_types) | (Optional) List of instance types associated with the EKS Node Group. | `list(object({ instance_type = string }))` | <pre>[<br>  {<br>    "instance_type": "m5.large"<br>  },<br>  {<br>    "instance_type": "m4.large"<br>  },<br>  {<br>    "instance_type": "t3.large"<br>  },<br>  {<br>    "instance_type": "t2.large"<br>  }<br>]</pre> | no |
| <a name="input_be_api_kubelet_args"></a> [be\_api\_kubelet\_args](#input\_be\_api\_kubelet\_args) | kubelet arguments for backend api work group | `string` | `""` | no |
| <a name="input_be_api_max_size"></a> [be\_api\_max\_size](#input\_be\_api\_max\_size) | (Required) The maximum size of the Auto Scaling Group. | `number` | `5` | no |
| <a name="input_be_api_min_size"></a> [be\_api\_min\_size](#input\_be\_api\_min\_size) | (Required) The minimum size of the Auto Scaling Group | `number` | `3` | no |
| <a name="input_be_api_on_demand_base_capacity"></a> [be\_api\_on\_demand\_base\_capacity](#input\_be\_api\_on\_demand\_base\_capacity) | (Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0 | `number` | `0` | no |
| <a name="input_be_api_on_demand_percentage"></a> [be\_api\_on\_demand\_percentage](#input\_be\_api\_on\_demand\_percentage) | (Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100 | `number` | `100` | no |
| <a name="input_be_api_on_demand_size"></a> [be\_api\_on\_demand\_size](#input\_be\_api\_on\_demand\_size) | n/a | `number` | `3` | no |
| <a name="input_be_devops_desired_size"></a> [be\_devops\_desired\_size](#input\_be\_devops\_desired\_size) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `1` | no |
| <a name="input_be_devops_instance_types"></a> [be\_devops\_instance\_types](#input\_be\_devops\_instance\_types) | (Optional) List of instance types associated with the EKS Node Group. | `list(object({ instance_type = string }))` | <pre>[<br>  {<br>    "instance_type": "m5.large"<br>  },<br>  {<br>    "instance_type": "m4.large"<br>  },<br>  {<br>    "instance_type": "t3.large"<br>  },<br>  {<br>    "instance_type": "t2.large"<br>  }<br>]</pre> | no |
| <a name="input_be_devops_kubelet_args"></a> [be\_devops\_kubelet\_args](#input\_be\_devops\_kubelet\_args) | kubelet arguments for backend devops work group | `string` | `""` | no |
| <a name="input_be_devops_max_size"></a> [be\_devops\_max\_size](#input\_be\_devops\_max\_size) | (Required) The maximum size of the Auto Scaling Group. | `number` | `5` | no |
| <a name="input_be_devops_min_size"></a> [be\_devops\_min\_size](#input\_be\_devops\_min\_size) | (Required) The minimum size of the Auto Scaling Group | `number` | `1` | no |
| <a name="input_be_devops_on_demand_base_capacity"></a> [be\_devops\_on\_demand\_base\_capacity](#input\_be\_devops\_on\_demand\_base\_capacity) | (Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0 | `number` | `0` | no |
| <a name="input_be_devops_on_demand_percentage"></a> [be\_devops\_on\_demand\_percentage](#input\_be\_devops\_on\_demand\_percentage) | (Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100 | `number` | `100` | no |
| <a name="input_be_devops_on_demand_size"></a> [be\_devops\_on\_demand\_size](#input\_be\_devops\_on\_demand\_size) | n/a | `number` | `0` | no |
| <a name="input_be_my_desired_size"></a> [be\_my\_desired\_size](#input\_be\_my\_desired\_size) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `3` | no |
| <a name="input_be_my_instance_types"></a> [be\_my\_instance\_types](#input\_be\_my\_instance\_types) | (Optional) List of instance types associated with the EKS Node Group. | `list(object({ instance_type = string }))` | <pre>[<br>  {<br>    "instance_type": "m5.large"<br>  },<br>  {<br>    "instance_type": "m4.large"<br>  },<br>  {<br>    "instance_type": "t3.large"<br>  },<br>  {<br>    "instance_type": "t2.large"<br>  }<br>]</pre> | no |
| <a name="input_be_my_kubelet_args"></a> [be\_my\_kubelet\_args](#input\_be\_my\_kubelet\_args) | kubelet arguments for backend my work group | `string` | `""` | no |
| <a name="input_be_my_max_size"></a> [be\_my\_max\_size](#input\_be\_my\_max\_size) | (Required) The maximum size of the Auto Scaling Group. | `number` | `5` | no |
| <a name="input_be_my_min_size"></a> [be\_my\_min\_size](#input\_be\_my\_min\_size) | (Required) The minimum size of the Auto Scaling Group | `number` | `3` | no |
| <a name="input_be_my_on_demand_base_capacity"></a> [be\_my\_on\_demand\_base\_capacity](#input\_be\_my\_on\_demand\_base\_capacity) | (Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0 | `number` | `0` | no |
| <a name="input_be_my_on_demand_percentage"></a> [be\_my\_on\_demand\_percentage](#input\_be\_my\_on\_demand\_percentage) | (Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100 | `number` | `100` | no |
| <a name="input_be_my_on_demand_size"></a> [be\_my\_on\_demand\_size](#input\_be\_my\_on\_demand\_size) | n/a | `number` | `3` | no |
| <a name="input_cloudbuild_service"></a> [cloudbuild\_service](#input\_cloudbuild\_service) | n/a | `string` | `"cloudbuild"` | no |
| <a name="input_cloudfront_dist_id_g2"></a> [cloudfront\_dist\_id\_g2](#input\_cloudfront\_dist\_id\_g2) | ## CloudFront Distributions ### | `string` | `"XXXXXXX"` | no |
| <a name="input_cloudfront_dist_id_g3"></a> [cloudfront\_dist\_id\_g3](#input\_cloudfront\_dist\_id\_g3) | n/a | `string` | `"XXXXXXX"` | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html) | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Number of days to retain log events. Default retention - 90 days | `number` | `90` | no |
| <a name="input_cluster_additional_security_group_ids"></a> [cluster\_additional\_security\_group\_ids](#input\_cluster\_additional\_security\_group\_ids) | List of additional, externally created security group IDs to attach to the cluster control plane | `list(string)` | `[]` | no |
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name` | `any` | `{}` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | <pre>[<br>  "audit",<br>  "api",<br>  "authenticator"<br>]</pre> | no |
| <a name="input_cluster_encryption_config"></a> [cluster\_encryption\_config](#input\_cluster\_encryption\_config) | Configuration block with encryption configuration for the cluster | <pre>list(object({<br>    provider_key_arn = string<br>    resources        = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_encryption_policy_description"></a> [cluster\_encryption\_policy\_description](#input\_cluster\_encryption\_policy\_description) | Description of the cluster encryption policy created | `string` | `"Cluster encryption policy to allow cluster role to utilize CMK provided"` | no |
| <a name="input_cluster_encryption_policy_name"></a> [cluster\_encryption\_policy\_name](#input\_cluster\_encryption\_policy\_name) | Name to use on cluster encryption policy created | `string` | `null` | no |
| <a name="input_cluster_encryption_policy_path"></a> [cluster\_encryption\_policy\_path](#input\_cluster\_encryption\_policy\_path) | Cluster encryption policy path | `string` | `null` | no |
| <a name="input_cluster_encryption_policy_tags"></a> [cluster\_encryption\_policy\_tags](#input\_cluster\_encryption\_policy\_tags) | A map of additional tags to add to the cluster encryption policy created | `map(string)` | `{}` | no |
| <a name="input_cluster_encryption_policy_use_name_prefix"></a> [cluster\_encryption\_policy\_use\_name\_prefix](#input\_cluster\_encryption\_policy\_use\_name\_prefix) | Determines whether cluster encryption policy name (`cluster_encryption_policy_name`) is used as a prefix | `string` | `true` | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cluster_iam_role_dns_suffix"></a> [cluster\_iam\_role\_dns\_suffix](#input\_cluster\_iam\_role\_dns\_suffix) | Base DNS domain name for the current partition (e.g., amazonaws.com in AWS Commercial, amazonaws.com.cn in AWS China) | `string` | `null` | no |
| <a name="input_cluster_identity_providers"></a> [cluster\_identity\_providers](#input\_cluster\_identity\_providers) | Map of cluster identity provider configurations to enable for the cluster. Note - this is different/separate from IRSA | `any` | `{}` | no |
| <a name="input_cluster_ip_family"></a> [cluster\_ip\_family](#input\_cluster\_ip\_family) | The IP family used to assign Kubernetes pod and service addresses. Valid values are `ipv4` (default) and `ipv6`. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | `""` | no |
| <a name="input_cluster_security_group_additional_rules"></a> [cluster\_security\_group\_additional\_rules](#input\_cluster\_security\_group\_additional\_rules) | List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source | `any` | `{}` | no |
| <a name="input_cluster_security_group_description"></a> [cluster\_security\_group\_description](#input\_cluster\_security\_group\_description) | Description of the cluster security group created | `string` | `"EKS cluster security group"` | no |
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | Existing security group ID to be attached to the cluster. Required if `create_cluster_security_group` = `false` | `string` | `""` | no |
| <a name="input_cluster_security_group_name"></a> [cluster\_security\_group\_name](#input\_cluster\_security\_group\_name) | Name to use on cluster security group created | `string` | `null` | no |
| <a name="input_cluster_security_group_tags"></a> [cluster\_security\_group\_tags](#input\_cluster\_security\_group\_tags) | A map of additional tags to add to the cluster security group created | `map(string)` | `{}` | no |
| <a name="input_cluster_security_group_use_name_prefix"></a> [cluster\_security\_group\_use\_name\_prefix](#input\_cluster\_security\_group\_use\_name\_prefix) | Determines whether cluster security group name (`cluster_security_group_name`) is used as a prefix | `string` | `true` | no |
| <a name="input_cluster_service_ipv4_cidr"></a> [cluster\_service\_ipv4\_cidr](#input\_cluster\_service\_ipv4\_cidr) | The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks | `string` | `null` | no |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | A map of additional tags to add to the cluster | `map(string)` | `{}` | no |
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | Create, update, and delete timeout configurations for the cluster | `map(string)` | `{}` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`) | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if EKS resources should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled | `bool` | `true` | no |
| <a name="input_create_cluster_security_group"></a> [create\_cluster\_security\_group](#input\_create\_cluster\_security\_group) | Determines if a security group is created for the cluster or use the existing `cluster_security_group_id` | `bool` | `true` | no |
| <a name="input_create_cni_ipv6_iam_policy"></a> [create\_cni\_ipv6\_iam\_policy](#input\_create\_cni\_ipv6\_iam\_policy) | Determines whether to create an [`AmazonEKS_CNI_IPv6_Policy`](https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-ipv6-policy) | `bool` | `false` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Determines whether a an IAM role is created or to use an existing IAM role | `bool` | `true` | no |
| <a name="input_create_node_security_group"></a> [create\_node\_security\_group](#input\_create\_node\_security\_group) | Determines whether to create a security group for the node groups or use the existing `node_security_group_id` | `bool` | `true` | no |
| <a name="input_custom_oidc_thumbprints"></a> [custom\_oidc\_thumbprints](#input\_custom\_oidc\_thumbprints) | Additional list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s) | `list(string)` | `[]` | no |
| <a name="input_eks_managed_node_group_defaults"></a> [eks\_managed\_node\_group\_defaults](#input\_eks\_managed\_node\_group\_defaults) | Map of EKS managed node group default configurations | `any` | `{}` | no |
| <a name="input_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#input\_eks\_managed\_node\_groups) | Map of EKS managed node group definitions to create | `any` | `{}` | no |
| <a name="input_eks_spot_enabled"></a> [eks\_spot\_enabled](#input\_eks\_spot\_enabled) | spot setting on self\_managed\_node\_groups | `bool` | `false` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Determines whether to create an OpenID Connect Provider for EKS to enable IRSA | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_fargate_profile_defaults"></a> [fargate\_profile\_defaults](#input\_fargate\_profile\_defaults) | Map of Fargate Profile default configurations | `any` | `{}` | no |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Map of Fargate Profile definitions to create | `any` | `{}` | no |
| <a name="input_hardened_worker_ami_linux"></a> [hardened\_worker\_ami\_linux](#input\_hardened\_worker\_ami\_linux) | The AMI from which to launch the instance | `string` | `""` | no |
| <a name="input_hardened_worker_ami_owner_id"></a> [hardened\_worker\_ami\_owner\_id](#input\_hardened\_worker\_ami\_owner\_id) | The AMI from which to launch the instance | `string` | `""` | no |
| <a name="input_iam_role_additional_policies"></a> [iam\_role\_additional\_policies](#input\_iam\_role\_additional\_policies) | Additional policies to be added to the IAM role | `list(string)` | `[]` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | Existing IAM role ARN for the cluster. Required if `create_iam_role` is set to `false` | `string` | `null` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | Cluster IAM role path | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | A map of additional tags to add to the IAM role created | `map(string)` | `{}` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Determines whether the IAM role name (`iam_role_name`) is used as a prefix | `string` | `true` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_mymail_service"></a> [mymail\_service](#input\_mymail\_service) | n/a | `string` | `"my-mail"` | no |
| <a name="input_node_security_group_additional_rules"></a> [node\_security\_group\_additional\_rules](#input\_node\_security\_group\_additional\_rules) | List of additional security group rules to add to the node security group created. Set `source_cluster_security_group = true` inside rules to set the `cluster_security_group` as source | `any` | `{}` | no |
| <a name="input_node_security_group_description"></a> [node\_security\_group\_description](#input\_node\_security\_group\_description) | Description of the node security group created | `string` | `"EKS node shared security group"` | no |
| <a name="input_node_security_group_id"></a> [node\_security\_group\_id](#input\_node\_security\_group\_id) | ID of an existing security group to attach to the node groups created | `string` | `""` | no |
| <a name="input_node_security_group_name"></a> [node\_security\_group\_name](#input\_node\_security\_group\_name) | Name to use on node security group created | `string` | `null` | no |
| <a name="input_node_security_group_tags"></a> [node\_security\_group\_tags](#input\_node\_security\_group\_tags) | A map of additional tags to add to the node security group created | `map(string)` | `{}` | no |
| <a name="input_node_security_group_use_name_prefix"></a> [node\_security\_group\_use\_name\_prefix](#input\_node\_security\_group\_use\_name\_prefix) | Determines whether node security group name (`node_security_group_name`) is used as a prefix | `string` | `true` | no |
| <a name="input_openid_connect_audiences"></a> [openid\_connect\_audiences](#input\_openid\_connect\_audiences) | List of OpenID Connect audience client IDs to add to the IRSA provider | `list(string)` | `[]` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | Identifies if the OS platform is `bottlerocket`, `linux`, or `windows` based | `string` | `"linux"` | no |
| <a name="input_prefix_separator"></a> [prefix\_separator](#input\_prefix\_separator) | The separator to use between the prefix and the generated timestamp for resource names | `string` | `"-"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | ############################################################################### Terragrunt input aws variable ############################################################################### | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_putin_khuylo"></a> [putin\_khuylo](#input\_putin\_khuylo) | Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo! | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_relayfe_service"></a> [relayfe\_service](#input\_relayfe\_service) | n/a | `string` | `"relay-fe-17"` | no |
| <a name="input_relayrs_service"></a> [relayrs\_service](#input\_relayrs\_service) | n/a | `string` | `"relay-rs-17"` | no |
| <a name="input_self_managed_node_group_defaults"></a> [self\_managed\_node\_group\_defaults](#input\_self\_managed\_node\_group\_defaults) | Map of self-managed node group default configurations | `any` | `{}` | no |
| <a name="input_self_managed_node_groups"></a> [self\_managed\_node\_groups](#input\_self\_managed\_node\_groups) | Map of self-managed node group definitions to create | `any` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs where the EKS cluster (ENIs) will be provisioned along with the nodes/node groups. Node groups can be deployed within a different set of subnet IDs from within the node group configuration | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster and its nodes will be provisioned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_nodes_role_name"></a> [all\_nodes\_role\_name](#output\_all\_nodes\_role\_name) | all role for self managed node groups created |
| <a name="output_aws_auth_configmap_yaml"></a> [aws\_auth\_configmap\_yaml](#output\_aws\_auth\_configmap\_yaml) | Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles |
| <a name="output_beapp_node_ami"></a> [beapp\_node\_ami](#output\_beapp\_node\_ami) | beapp\_node\_ami |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cluster_addons"></a> [cluster\_addons](#output\_cluster\_addons) | Map of attribute maps for all EKS cluster addons enabled |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster |
| <a name="output_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#output\_cluster\_primary\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | ID of the cluster security group |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| <a name="output_decode_cluster_certificate_authority_data"></a> [decode\_cluster\_certificate\_authority\_data](#output\_decode\_cluster\_certificate\_authority\_data) | decode certificate data required to communicate with the cluster |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created |
| <a name="output_fargate_profiles"></a> [fargate\_profiles](#output\_fargate\_profiles) | Map of attribute maps for all EKS Fargate Profiles created |
| <a name="output_node_security_group_arn"></a> [node\_security\_group\_arn](#output\_node\_security\_group\_arn) | Amazon Resource Name (ARN) of the node shared security group |
| <a name="output_node_security_group_id"></a> [node\_security\_group\_id](#output\_node\_security\_group\_id) | ID of the node shared security group |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
| <a name="output_secretsmanager_secret_name"></a> [secretsmanager\_secret\_name](#output\_secretsmanager\_secret\_name) | secrets manager for stored eks application secret |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created |
<!-- END_TF_DOCS -->