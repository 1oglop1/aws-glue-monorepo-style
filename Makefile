BASEDIR=$(CURDIR)
TF_DIR=$(BASEDIR)/terraform/solution

# Check if deploy environment is set!
variables := TF_STATE_BUCKET

fatal_if_undefined = $(if $(findstring undefined,$(origin $1)),$(error Error: variable [$1] is undefined))
$(foreach 1,$(variables),$(fatal_if_undefined))


.PHONY: help
help:		## This help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

tf-apply:  ## terraform apply
	cd $(TF_DIR) && terraform apply -auto-approve

tf-init:  ## terraform init
	cd $(TF_DIR) && terraform init -backend-config "bucket=${TF_STATE_BUCKET}" -backend-config "key=tf.state"

tf-plan:  ## terraform plan
	cd $(TF_DIR) && terraform plan

tf-destroy:  ## terraform destroy
	cd $(TF_DIR) && terraform destroy -force

jobs-deploy:  ## deploy glue jobs
	bash glue-jobs.sh deploy

jobs-package:  ## package glue jobs
	bash glue-jobs.sh package

jobs-clean:  ## clean glue jobs
	bash glue-jobs.sh clean
