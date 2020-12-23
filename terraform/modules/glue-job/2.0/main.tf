resource "aws_glue_job" "job" {
  name        = var.name
  connections = var.connections

  number_of_workers = var.number_of_workers
  worker_type = var.worker_type

  max_retries = var.max_retries

  glue_version = "2.0"

  command {
    name            = "glueetl"
    script_location = var.script_location
  }

  default_arguments = var.default_arguments
  description       = var.description
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }

  role_arn = var.role_arn
  tags     = var.tags
}
