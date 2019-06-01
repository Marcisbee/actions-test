workflow "Build and test" {
  on = "push"
  resolves = ["Test", "Lint", "Bundle"]
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "Bundle" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "build"
}

action "Lint" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "lint"
}

action "Test" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "test"
}
