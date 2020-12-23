output "job_name" {
  description="AWS Glue Job Name"
  value = aws_glue_job.job.name
}

output "job_arn" {
  description="AWS Glue Job ARN"
  value = aws_glue_job.job.arn
}
