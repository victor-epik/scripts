#!/bin/bash

currentcwd=$(pwd)
# If we are missing AWS CLI, install it
if ! command -v aws &> /dev/null
then
  cd /tmp
  echo "AWS CLI could not be found, installing..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install


fi

# If we are missing docker-credential-ecr-login, install it
if ! command -v docker-credential-ecr-login &> /dev/null
then
  # Install ECR credential helper
  sudo apt update
  sudo apt install amazon-ecr-credential-helper -y
  jq '.credHelpers."159104148769.dkr.ecr.us-west-2.amazonaws.com" = "ecr-login" | .credHelpers."public.ecr.aws" = "ecr-login"' ~/.docker/config.json | sponge ~/.docker/config.json
fi


cd $currentcwd

