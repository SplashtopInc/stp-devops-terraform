<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Required) The AZ where the EBS volume will exist. | `string` | `""` | no |
| <a name="input_ebs_name"></a> [ebs\_name](#input\_ebs\_name) | name of ebs | `string` | `"ebs_test"` | no |
| <a name="input_ebs_tags"></a> [ebs\_tags](#input\_ebs\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "DLM-snapshot": "true"<br>}</pre> | no |
| <a name="input_eks_instance_name"></a> [eks\_instance\_name](#input\_eks\_instance\_name) | name of instance | `list(any)` | `[]` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | If true, the disk will be encrypted. | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. | `string` | `""` | no |
| <a name="input_size"></a> [size](#input\_size) | The size of the drive in GiBs. | `number` | `20` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1 | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ebs-id"></a> [ebs-id](#output\_ebs-id) | n/a |
| <a name="output_eks-node-instance-zone"></a> [eks-node-instance-zone](#output\_eks-node-instance-zone) | n/a |
<!-- END_TF_DOCS -->