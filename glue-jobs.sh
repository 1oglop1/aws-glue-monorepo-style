#!/usr/bin/env bash
set -e
# This script packages orchestrates packaging and uploading of all glue jobs.
# The idea is to run different Make targets to get desired effect.
# While each Glue Job should comply with the structure and provide
# necessary Make targets:
# package - create a deployable package
# test - run tests
# deploy - make the package and upload it to S3
# In the end S3 content will be glue_job.py and glue_job_deps.zip

ARGUMENT=$1
OPTIONS="package|test|deploy|clean"

if [[ ${OPTIONS} != *"$ARGUMENT"* ]]; then
  echo "Argument must match one of ${OPTIONS}"
  exit 1
fi

echo GLUEING GLUE
# Deploy data source specific jobs
for DIR in glue/data_sources/*/*; do
  if [[ -d ${DIR} ]]; then
    if [[ -e ${DIR}/Makefile ]]; then
      cd ${DIR}
      echo --------${DIR}-------------
      make ${ARGUMENT}
      echo ---------------------------
      cd -
    fi
  fi;
done

# Deploy general jobs
for DIR in glue/shared/glue_jobs/*; do
  if [[ -d ${DIR} ]]; then
    if [[ -e ${DIR}/Makefile ]]; then
      cd ${DIR}
      echo --------${DIR}-------------
      make ${ARGUMENT}
      echo ---------------------------
      cd -
    fi
  fi;
done
