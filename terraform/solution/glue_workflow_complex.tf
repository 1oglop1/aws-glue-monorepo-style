module "glue_workflow_complex" {
  source        = "../modules/glue-workflow"
  workflow_name = "etl-workflow-complex"
  security_name = "glueSecurityConfigComplex"
}

###################### Glue Triggers and DAG ########################################

locals {
  jobs_0_1 = [
    module.dummy_job["dummy_job_0"].job_name,
    module.dummy_job["dummy_job_1"].job_name
  ]
  job_2 = module.dummy_job["dummy_job_2"].job_name
  jobs_3_5 = [
    module.dummy_job["dummy_job_3"].job_name,
    module.dummy_job["dummy_job_4"].job_name,
    module.dummy_job["dummy_job_5"].job_name
  ]
}

# starts 2 jobs
resource "aws_glue_trigger" "start_complex" {
  name          = "start_complex"
  type          = "ON_DEMAND"
  workflow_name = module.glue_workflow_complex.workflow_name

  dynamic "actions" {
    for_each = local.jobs_0_1
    content {
      job_name = actions.value
    }
  }
}

# waits for first 2 jobs to finish
resource "aws_glue_trigger" "complex_stage_2" {
  name          = "complex_stage_2"
  type          = "CONDITIONAL"
  workflow_name = module.glue_workflow_complex.workflow_name

  actions {
    job_name = local.job_2
  }
  predicate {
    dynamic "conditions" {
      for_each = local.jobs_0_1
      content {
        job_name = conditions.value
        state    = "SUCCEEDED"
      }
    }
  }
}

resource "aws_glue_trigger" "wait_for_second" {
  name = "complex_stage_3"
  type = "CONDITIONAL"
  workflow_name = module.glue_workflow_complex.workflow_name

  dynamic "actions" {
    for_each = local.jobs_3_5
    content {
      job_name = actions.value
    }
  }

  predicate {
    conditions {
      job_name = local.job_2
      state    = "SUCCEEDED"
    }
  }
}
