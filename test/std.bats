#!/usr/bin/env bats
#Tests for std.lib
. ../lib/log.lib
. ../lib/std.lib

@test "function sflib_std_init exist" {
   command -v sflib_std_init
}
