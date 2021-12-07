include {
  path = find_in_parent_folders("root.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

dependency "iam" {
  config_path = "./iam"
}

terraform {
  #pin this to a specific tag/version when in another git repo
  source = ""
}

inputs = {

}
