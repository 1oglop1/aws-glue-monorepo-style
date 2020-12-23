# Glue Python Shell job

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
| connections | The list of connections used for this job. | `list(string)` | `[]` | no |
| default\_arguments | The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide. | `map(string)` | `{}` | no |
| description | Description of the job. | `string` | `""` | no |
| max\_capacity | The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs. Required when pythonshell is set, accept either 0.0625 or 1.0. | `string` | `"0.0625"` | no |
| max\_concurrent\_runs | The maximum number of concurrent runs allowed for a job. The default is 1. | `string` | `"1"` | no |
| max\_retries | Number of retries | `string` | `null` | no |
| name | Name of the job | `string` | n/a | yes |
| python\_version | The Python version being used to execute a Python shell job. Allowed values are 2 or 3. | `string` | `"3"` | no |
| role\_arn | The ARN of the IAM role associated with this job. | `string` | n/a | yes |
| script\_location | Specifies the S3 path to a script that executes a job. | `string` | n/a | yes |
| tags | AWS resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| job\_arn | AWS Glue Job ARN |
| job\_name | AWS Glue Job Name |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
