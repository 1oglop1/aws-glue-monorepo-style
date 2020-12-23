output "workflow_name" {
  description="AWS Glue Workflow Name"
  value = aws_glue_workflow.glue_workflow.name
}
