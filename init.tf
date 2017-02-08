#!/bin/bash -e
 
PROJECT="$(basename `pwd`)"
BUCKET="us-west-2a.terraform.remotestate.sb"
 
init() {
  if [ -d .terraform ]; then
    if [ -e .terraform/terraform.tfstate ]; then
      echo "Remote state already exist!"
      if [ -z $IGNORE_INIT ]; then
        exit 1
      fi
    fi
  fi
 
 
  terraform remote config \
    -backend=s3 \
    -backend-config="bucket=${BUCKET}" \
    -backend-config="key=${PROJECT}/terraform.tfstate" \
    -backend-config="${var.region}"
 
}
 
while getopts "i" opt; do
  case "$opt" in
    i)
      IGNORE_INIT="true"
      ;;
  esac
done
 
shift $((OPTIND-1))
 
init
