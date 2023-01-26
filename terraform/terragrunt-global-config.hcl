locals {
  aws_profile = "ippon-sandbox"
}

inputs = {
  aws_profile = local.aws_profile
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "taufort-gha-demo-tf-states"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
    dynamodb_table = "taufort-gha-demo-tf-states"
    profile        = local.aws_profile
  }
}
