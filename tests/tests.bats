#!/usr/bin/env bats

load test_helper

#
# Parsing
#
@test "knows when an identity is incomplete but doesn't throw if unfinished" {
#   create_identities_file <<EOF
# [identity:test]
#   name = Connor Atherton
# EOF
#
#   move_to_random_repo
#   run git identify
#   debug "$GIT_IDENTITIES"
#
#   [ "$status" -eq 0 ]
}

# @test "knows when an identity is incomplete and throws if new identity started" {
#   create_identities_file "$(cat <<EOF
# [identity:test2]
#
# [identity:test]
#   name = Connor Atherton
# EOF)"
#
#   move_to_random_repo
#   run git identify
#   debug_test
#
#   [ "$status" -eq 1 ]
# }

@test "errors if an identity decleration is left blank" {
  create_identities_file "$(cat <<EOF
[identity:test2]

[identity:test]
  name = Connor Atherton
EOF)"

  move_to_random_repo
  run git identify
  debug_test

  [ "$status" -eq 1 ]
}

@test "It strips whitespace" {
#   create_identities_file <<EOF
#     [identity:test]
# name=            Connor Atherton
#         email     = connor@email.com
# EOF
}

@test "Doesn't care when an identity has no rules" {

}

#
# Matching
#
@test "Works for both identities" {
}

@test "Works for globs in pathnames" {

}

