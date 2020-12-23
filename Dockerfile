FROM amazon/aws-glue-libs:glue_libs_1.0.0_image_01

ARG TERRAFORM_VERSION="0.14.3"

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN pip install -U pip && \
    pip install -U wheel && \
    pip install -U setuptools && \
    pip install -U awscli boto3
