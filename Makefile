BASEDIR=$(CURDIR)
TF_DIR=$(BASEDIR)/terraform/solution

# Check if deploy environment is set!
ifndef TF_VAR_account_id
$(error TF_VAR_account_id is not set)
endif

.PHONY: help
help:		## This help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

tf-apply:  ## terraform apply
	cd $(TF_DIR) && terraform apply -auto-approve

tf-init:  ## terraform init
	cd $(TF_DIR) && terraform init

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