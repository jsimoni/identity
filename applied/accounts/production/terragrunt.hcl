generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::452012047556:role/GitHubActions_Workflow_role2"
  }
}
EOF
}

#    role_arn = "arn:aws:iam::452012047556:role/GitHubActions_Workflow_role2"
#    role_arn = "arn:aws:iam::${local.common.aws_account_id}:role/GitHubActions_Workflow_role2"
