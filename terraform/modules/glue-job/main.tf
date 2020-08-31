resource "aws_glue_job" "example" {
  name         = var.name
  connections  = var.connections

  max_capacity = var.max_capacity

  number_of_workers = var.number_of_workers
  worker_type       = var.worker_type 

  max_retries  = var.max_retries

  glue_version = var.glue_version

  command {
    name            = var.job_command
    script_location = var.script_location
    python_version  = var.python_version
  }

  default_arguments = var.default_arguments
  description       = var.description
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }

  role_arn = var.role_arn
  tags     = var.tags
}