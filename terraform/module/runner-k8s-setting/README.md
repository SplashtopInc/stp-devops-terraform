<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.runner-deployment](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_horizontal_pod_autoscaler.runner-hpa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler) | resource |
| [kubernetes_namespace.runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.runner-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dind_resources_cpu_limits"></a> [dind\_resources\_cpu\_limits](#input\_dind\_resources\_cpu\_limits) | dind container resources cpu limits | `string` | `"2"` | no |
| <a name="input_dind_resources_cpu_requests"></a> [dind\_resources\_cpu\_requests](#input\_dind\_resources\_cpu\_requests) | dind container resources cpu requests | `string` | `"200m"` | no |
| <a name="input_dind_resources_memory_limits"></a> [dind\_resources\_memory\_limits](#input\_dind\_resources\_memory\_limits) | dind container resources memory limits | `string` | `"2048Mi"` | no |
| <a name="input_dind_resources_memory_requests"></a> [dind\_resources\_memory\_requests](#input\_dind\_resources\_memory\_requests) | dind container resources memory requests | `string` | `"512Mi"` | no |
| <a name="input_gh_token"></a> [gh\_token](#input\_gh\_token) | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| <a name="input_pods_numbers"></a> [pods\_numbers](#input\_pods\_numbers) | Number of the Github Action pods | `number` | `2` | no |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | Name of the repo for the Github Action | `string` | n/a | yes |
| <a name="input_repo_owner"></a> [repo\_owner](#input\_repo\_owner) | Owner of the repo for the Github Action | `string` | n/a | yes |
| <a name="input_repo_url"></a> [repo\_url](#input\_repo\_url) | Repo URL for the Github Action | `string` | n/a | yes |
| <a name="input_runner_iamge"></a> [runner\_iamge](#input\_runner\_iamge) | Github Action image | `string` | `"public.ecr.aws/k7c3r6j5/gh-runner:latest"` | no |
| <a name="input_runner_k8s_config"></a> [runner\_k8s\_config](#input\_runner\_k8s\_config) | Name for the k8s secret required to configure gh runners on EKS | `string` | `"runner-k8s-config"` | no |
| <a name="input_runner_namespace"></a> [runner\_namespace](#input\_runner\_namespace) | ## Site information ### | `string` | `"runner"` | no |
| <a name="input_runner_resources_cpu_limits"></a> [runner\_resources\_cpu\_limits](#input\_runner\_resources\_cpu\_limits) | runner container resources cpu limits | `string` | `"1"` | no |
| <a name="input_runner_resources_cpu_requests"></a> [runner\_resources\_cpu\_requests](#input\_runner\_resources\_cpu\_requests) | runner container resources cpu limits | `string` | `"100m"` | no |
| <a name="input_runner_resources_memory_limits"></a> [runner\_resources\_memory\_limits](#input\_runner\_resources\_memory\_limits) | runner container resources memory limits | `string` | `"1024Mi"` | no |
| <a name="input_runner_resources_memory_requests"></a> [runner\_resources\_memory\_requests](#input\_runner\_resources\_memory\_requests) | runner container resources memory limits | `string` | `"256Mi"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_runner_deployment"></a> [runner\_deployment](#output\_runner\_deployment) | n/a |
| <a name="output_runner_hpa"></a> [runner\_hpa](#output\_runner\_hpa) | n/a |
| <a name="output_runner_namespace"></a> [runner\_namespace](#output\_runner\_namespace) | n/a |
| <a name="output_runner_secret"></a> [runner\_secret](#output\_runner\_secret) | n/a |
<!-- END_TF_DOCS -->