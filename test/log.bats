#!/usr/bin/env bats

#Tests for log.lib
setup() {
  . "$BATS_TEST_DIRNAME/../lib/log.lib"
  . "$BATS_TEST_DIRNAME/../lib/std.lib"

  rep_log=.
  script_nom=test_log
}

@test "DESCRIBE sflib_log_sortie" {
  command -v sflib_log_sortie
}

@test "DESCRIBE sflib_log_debug" {
  command -v sflib_log_init
}

@test "  -> return zero string without DEBUG mode" {
  DEBUG=0
  run sflib_log_debug "test debug"
    [ -z $output ]
}

@test "  -> return a nonzero string with DEBUG mode" {
  DEBUG=1
  run sflib_log_debug "test debug"
    [ ! -z "$output" ]
}

@test "DESCRIBE sflib_log_init" {
  command -v sflib_log_init
}

@test "  -> define all variables" {
  sflib_log_init
    [ -n $PERE ]
    [ -n $FILS ]
    [ -n $PID ]
    [ -n $output ]
}

@test "DESCRIBE sflib_log_create exist" {
  command -v sflib_log_create
}

@test "  -> create file in log rep" {
skip
  rep_log=$BATS_TMPDIR/rep_test_log
  run sflib_log_create
  [ $status -eq 0 ]
  echo "o=$output"
  echo "fic_log=$fic_log"
  [ -e $fic_log ]
  echo toto
}
