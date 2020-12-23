module "glue_workflow_simple" {
  source        = "../modules/glue-workflow"
  workflow_name = "etl-workflow-simple"
  security_name = "glueSecurityConfigSimple"
}

###################### Glue Triggers and DAG ########################################

resource "aws_glue_trigger" "start_raw_to_refined" {
  name = "start_raw_to_refined"
  type = "ON_DEMAND"
  workflow_name = module.glue_workflow_simple.workflow_name
  actions {
    job_name = module.ds1_raw_to_refined_job.job_name
  }
}

resource "aws_glue_trigger" "run_refined_to_curated" {
  name = "run_refined_to_curated"
  type = "CONDITIONAL"
  workflow_name = module.glue_workflow_simple.workflow_name
  actions {
    job_name = module.ds1_refined_to_curated_job.job_name
  }

  predicate {
    conditions {
      job_name = module.ds1_raw_to_refined_job.job_name
      state    = "SUCCEEDED"
    }
  }
}
