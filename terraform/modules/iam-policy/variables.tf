########################################################
##               Module variables
########################################################

variable "iam_role_policy_name" {
  type        = string
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
}

variable "iam_role_policy" {
  type        = string
  description = "The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform"
}

variable "attachment_name" {
  type        = string
  description = "The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform"
}

variable "roles" {
  type        = list
  description = "The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform"
}

