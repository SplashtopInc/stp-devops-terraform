<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.12.1 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_auth_backend.kubernetes](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_generic_secret.env-json](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_kubernetes_auth_backend_config.config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_config) | resource |
| [vault_kubernetes_auth_backend_role.role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_mount.kvv2](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.K8S_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [aws_secretsmanager_secret.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [kubernetes_secret.vault](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | n/a | `string` | `"tperd"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | `""` | no |
| <a name="input_env_json"></a> [env\_json](#input\_env\_json) | n/a | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"test"` | no |
| <a name="input_secretsmanager_secret_name"></a> [secretsmanager\_secret\_name](#input\_secretsmanager\_secret\_name) | eks cluster secrets manager secret name | `string` | `""` | no |
| <a name="input_vault_k8s_auth_host"></a> [vault\_k8s\_auth\_host](#input\_vault\_k8s\_auth\_host) | n/a | `string` | `""` | no |
| <a name="input_vault_k8s_auth_jwt"></a> [vault\_k8s\_auth\_jwt](#input\_vault\_k8s\_auth\_jwt) | ## auth config### | `string` | `"eyJhbGc"` | no |
| <a name="input_vault_k8s_ca"></a> [vault\_k8s\_ca](#input\_vault\_k8s\_ca) | n/a | `string` | `""` | no |
| <a name="input_vault_k8s_role_token_ttl"></a> [vault\_k8s\_role\_token\_ttl](#input\_vault\_k8s\_role\_token\_ttl) | ## auth role ### | `number` | `14400` | no |
| <a name="input_vault_mount_path"></a> [vault\_mount\_path](#input\_vault\_mount\_path) | ## secrets ### | `string` | `"test"` | no |
| <a name="input_vault_mount_type"></a> [vault\_mount\_type](#input\_vault\_mount\_type) | n/a | `string` | `"kv"` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | n/a | `string` | `"vault"` | no |
| <a name="input_vault_project"></a> [vault\_project](#input\_vault\_project) | n/a | `string` | `"be-app"` | no |
| <a name="input_vault_sa_name"></a> [vault\_sa\_name](#input\_vault\_sa\_name) | ## for local var ### | `string` | `"vault-serviceaccount"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault"></a> [vault](#output\_vault) | n/a |
<!-- END_TF_DOCS -->