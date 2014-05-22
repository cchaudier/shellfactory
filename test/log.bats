#!/usr/bin/env bats

#Tests for log.lib
setup() {
  . "$BATS_TEST_DIRNAME/../lib/log.lib"
  . "$BATS_TEST_DIRNAME/../lib/std.lib"

  rep_log=.
}

@test "function sflib_log_init exist" {
  run sflib_log_init
    [ "$status" -eq 0 ]
}

@test "function sflib_log_sortie exist" {
  run sflib_log_sortie
    [ "$status" -eq 0 ]
}

@test "function sflib_log_create exist" {
skip
  run sflib_log_create
    [ $status -eq 0 ]
}

@test "function sflib_log_debug exist" {
  run sflib_log_debug
    [ "$status" -eq 0 ]
}
