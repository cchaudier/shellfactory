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
  run sflib_log_init
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

@test "DESCRIBE sflib_log_trace" {
  command -v sflib_log_trace
}

@test "DESCRIBE trace" {
  command -v trace
}

@test "  -> trace contain '[*] test_trace'" {
  run trace test_trace
  [ $status -eq 0 ]
  [ $(expr "$output" : ".*\[\*\] test_trace") -ne 0 ]
}

@test "DESCRIBE warning" {
  command -v warning
}

@test "  -> warning contain '[=] test_warning'" {
  run warning test_warning
  [ $status -eq 0 ]
  [ $(expr "$output" : ".*\[\=\] test_warning") -ne 0 ]
}


@test "DESCRIBE erreur" {
  command -v erreur
}

@test "  -> erreur contain '[-] test_erreur'" {
  run erreur test_erreur
  [ $status -eq 0 ]
  [ $(expr "$output" : ".*\[\-\] test_erreur") -ne 0 ]
}

@test "DESCRIBE debug" {
  command -v debug
}

@test "  -> debug contain '[D] test_debug'" {
  DEBUG=1
  run debug test_debug
  [ $status -eq 0 ]
  [ $(expr "$output" : ".*\[\D\] test_debug") -ne 0 ]
}
