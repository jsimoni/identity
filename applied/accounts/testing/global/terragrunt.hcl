include {
  path = find_in_parent_folders("root.hcl")
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::133666418894:role/GitHubAction_Identity_Role"
  }
}
EOF
}

terraform {
  source = "../../../../modules//iam"
}

inputs = {

}
