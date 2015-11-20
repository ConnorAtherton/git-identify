#!/bin/bash

TEST_IDENTITIES_BASE="$(pwd)/.git_identities_base"
TEST_IDENTITIES="$(pwd)/.git_identities"
TEST_REPOS_DIR="$(pwd)/repos"

setup() {
  # cp "$TEST_IDENTITIES_BASE" "$TEST_IDENTITIES"
  mkdir "$TEST_REPOS_DIR"
  export GIT_IDENTITIES="$TEST_IDENTITIES"
}

teardown() {
  # rm -f "$TEST_IDENTITIES"
  rm -rf "$TEST_REPOS_DIR"
  unset GIT_IDENTITIES
}

append_to_file() {
  echo "$1\n" >> "$TEST_IDENTITIES"
}

# 1 the string contents of the new file
create_identities_file() {
  debug "$1"
  rm -f "$TEST_IDENTITIES"
  echo "$1" > "$TEST_IDENTITIES"
}

# 1 - the name of the identity to add
# ..2 - The rules to add
append_identity_rule() {
  local $identity = "$1"
  shift

  append_to_file "[$identity]"

  for rule in "$@"; do
    append_to_file "  $rule"
  done
}

# 1 - name of the repo to create
create_git_repo() {
  cd "$TEST_REPOS_DIR"
  mkdir -p "$1" && cd "$1"
  git init --bare
}

# Use the to move to a temp git repo
move_to_random_repo() {
  local random_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  create_git_repo "$random_name"
}

# 1 - name of the directory to move to
move_to_repo() {
  cd "$TEST_REPOS_DIR/$1"
}

debug() {
  echo -e "[`date -u`] ---\n $1\n" >> "$BATS_TEST_DIRNAME/test.log"
}

debug_test() {
  debug " status: $status\n  output: $output\n  lines: ${lines[@]}"
}