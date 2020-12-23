# Generated docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attachment\_name | The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform | `string` | n/a | yes |
| iam\_role\_policy | The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform | `string` | n/a | yes |
| iam\_role\_policy\_name | The name of the policy. If omitted, Terraform will assign a random, unique name. | `string` | n/a | yes |
| roles | The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform | `list(any)` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
