# https://www.bti360.com/creating-a-terraform-variable-hierarchy-with-terragrunt/

locals {
  root_deployments_dir       = get_parent_terragrunt_dir()
  relative_deployment_path   = path_relative_to_include()
  deployment_path_components = compact(split("/", local.relative_deployment_path))
  # Get a list of every path between root_deployments_directory and the path of
  # the deployment
  possible_config_dirs = [
    for i in range(0, length(local.deployment_path_components) + 1) :
    join("/", concat(
      [local.root_deployments_dir],
      slice(local.deployment_path_components, 0, i)
    ))
  ]
  # Generate a list of possible config files at every possible_config_dir
  # (support both .yml and .yaml)
  possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/config.yml",
      "${dir}/config.yaml"
    ]
  ])
  # Load every YAML config file that exists into an HCL object
  file_configs = [
    for path in local.possible_config_paths :
    yamldecode(file(path)) if fileexists(path)
  ]
  # Merge the objects together, with deeper configs overriding higher configs
  merged_config = merge(local.file_configs...)
}

# Pass the merged config to terraform as variable values using TF_VAR_
# environment variables
inputs = local.merged_config


remote_state = {
  backend = "s3"
  disable_init = "false"
  config = {
    bucket         = "ipipeline-iam-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "ipipeline-iam-terraform-state-locks"
    role_arn       = "arn:aws:iam::940407795328:role/GitHubAction_Identity_Backend_Role"
  }
}

generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {
  }
}
EOF
}

terraform {
  after_hook "after_hook_plan" {
      commands     = ["plan"]
      execute      = ["sh", "-c", "mkdir -p ${get_parent_terragrunt_dir()}/plans/${path_relative_to_include()}; terraform show -json tfplan.binary | jq '.' > ${get_parent_terragrunt_dir()}/plans/${path_relative_to_include()}/plan.json"]
  }
}
