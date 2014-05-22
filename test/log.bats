#!/usr/bin/env bats

#Tests for log.lib
. ../lib/log.lib

@test "function sflib_log_init exist" {
  run sflib_log_init
    [ "$status" -eq 0 ]
}

@test "function sflib_log_sortie exist" {
  run sflib_log_debug
    [ "$status" -eq 0 ]
}

@test "function sflib_log_create exist" {
  run sflib_log_debug
    [ "$status" -eq 0 ]
}

@test "function sflib_log_debug exist" {
  run sflib_log_debug
    [ "$status" -eq 0 ]
}
