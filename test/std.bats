#!/usr/bin/env bats
#Tests for std.lib
. ../.lib/log.lib

@test "function sflib_log_init exist" {
  run sflib_log_init
    [ "$status" -eq 0 ]
}
