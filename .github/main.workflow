workflow "Build and test" {
  on = "push"
  resolves = ["Publish"]
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "Bundle" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "run build"
}

action "Lint" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "run lint"
}

action "Test" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "test"
}

# Filter for a new tag
action "Tag" {
  needs = "Test"
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "Publish" {
  needs = "Tag"
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}
