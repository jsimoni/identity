terraform {
  after_hook "after_hook_plan" {
      commands     = ["plan"]
      execute      = ["sh", "-c", "terraform show -json tfplan.binary > tfplan.json"]
      run_on_error = true
  }
}
