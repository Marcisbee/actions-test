workflow "Build, Test, Lint and Publish" {
  on = "push"
  resolves = ["Publish"]
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "Lint" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "run lint"
}

action "Test" {
  needs = "Lint"
  uses = "actions/npm@master"
  args = "test"
}

action "Bundle" {
  needs = "Test"
  uses = "actions/npm@master"
  args = "run build"
}

# Filter for a new tag
action "Tag" {
  needs = "Bundle"
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "Publish" {
  needs = "Tag"
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}
