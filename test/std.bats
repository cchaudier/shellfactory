#!/usr/bin/env bats
#Tests for std.lib
. ../lib/std.lib

@test "function sflib_std_init exist" {
  run sflib_std_init
    [ "$status" -eq 0 ]
}
