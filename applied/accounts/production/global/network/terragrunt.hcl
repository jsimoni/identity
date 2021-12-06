include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  #pin this to a specific tag/version when in another git repo
  source = "../../../../../modules//network"
}

inputs = {

}
