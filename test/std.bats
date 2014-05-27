#!/usr/bin/env bats
#Tests for std.lib
. ../lib/log.lib
. ../lib/std.lib

sortie() {
  return $SEVERITE
}

@test "DESCRIBE sflib_std_init exist" {
  command -v sflib_std_init
}

@test "DESCRIBE sflib_std_sortie exist" {
  command -v sflib_std_sortie
}

@test "DESCRIBE sflib_std_rep_test exist" {
skip
  command -v sflib_std_rep_test
}

@test "DESCRIBE sflib_std_test_returncode" {
  command -v sflib_std_test_returncode
}

@test "  -> don't print message if cr is true" {
  true
  run sflib_std_test_returncode "Don't print msg"
  [ "$status" -eq 0 ]
  echo "$output"|grep -v "Don't print msg"
}

@test "  -> print message if cr is false" {
  run 'false; sflib_std_test_returncode "print msg"'
  [ "$status" -ne 202 ]
  echo "$output"|grep "print msg"
}

@test "DESCRIBE sflib_std_rep_create" {
  command -v sflib_std_rep_create
}

