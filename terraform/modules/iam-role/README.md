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
| assume\_role\_policy | The policy that grants an entity permission to assume the role. | `string` | n/a | yes |
| iam\_role\_name | The name of the role. If omitted, Terraform will assign a random, unique name. | `string` | n/a | yes |
| tags | Key-value mapping of tags for the IAM role | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | IAM role ARN |
| iam\_role\_id | IAM role id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
