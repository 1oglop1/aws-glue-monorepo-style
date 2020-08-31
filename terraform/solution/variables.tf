# Initialize variables
#
# All variables set in ./terraform.tfvars must be initialized here
#
# Any of these variables can be used in any of this environment's .tf files

########################################
# Account metadata
########################################
variable account_id {}

variable assume_role_name {}

variable infra_provisioner {}
variable region {}
variable tags {}
variable glue_role {}

