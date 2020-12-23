resource "aws_glue_workflow" "glue_workflow" {
  name = var.workflow_name
}

resource "aws_glue_security_configuration" "glue_security" {
  name = var.security_name

  encryption_configuration {
    cloudwatch_encryption {
    }

    job_bookmarks_encryption {
    }

    s3_encryption {
      s3_encryption_mode = "SSE-S3"
    }
  }
}
