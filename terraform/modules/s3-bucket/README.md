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
| bucket\_name | The name of the bucket | `string` | n/a | yes |
| tags | Tags associated with the bucket | `map(any)` | n/a | yes |
| versioning\_enabled | Enable versioning | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | S3 bucket ARN |
| id | S3 bucket ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
