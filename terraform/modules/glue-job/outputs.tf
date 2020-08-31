output "glue_job_name" {
  value = aws_glue_job.example.id
}

output "glue_job_arn" {
  value = aws_glue_job.example.arn
}