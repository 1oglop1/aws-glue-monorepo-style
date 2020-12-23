output "iam_role_id" {
  description = "IAM role id"
  value       = aws_iam_role.role.id
}

output "iam_role_arn" {
  description = "IAM role ARN"
  value       = aws_iam_role.role.arn
}
