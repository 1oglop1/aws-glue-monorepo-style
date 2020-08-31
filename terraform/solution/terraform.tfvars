
########################################
# Account metadata
########################################

assume_role_name   = "terraform-user"
infra_provisioner  = "terraform"
region             = "us-east-1"

tags = {
  "terraform" = "true"
}

glue_role = "glue-role"
