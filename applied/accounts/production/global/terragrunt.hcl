include {
  path = find_in_parent_folders("root.hcl")
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::452012047556:role/GitHubAction_Identity_Role"
  }
}
EOF
}

terraform {
  source = "../../../../modules//iam"
}

inputs = {

}

terraform {
  after_hook "after_hook_plan" {
      commands     = ["plan"]
      execute      = ["sh", "-c", "terraform show -json tfplan.binary > tfplan.json"]
      run_on_error = true
  }
}
