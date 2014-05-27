#!/usr/bin/env bats
#Tests for std.lib
setup() {
  . "$BATS_TEST_DIRNAME/../lib/log.lib"
  . "$BATS_TEST_DIRNAME/../lib/std.lib"

  rep_log=.
  script_nom=test_log
}

sortie() {
  exit  $SEVERITE
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
  run "false; sflib_std_test_returncode 'print msg'"
  [ "$status" -ne 0 ]
  echo "$output"|grep "print msg"
}

@test "DESCRIBE sflib_std_rep_create" {
  command -v sflib_std_rep_create
}

@test "  -> rep is not created and rc is not null" {
  rep=/root/test_rep_not_created
  run sflib_std_rep_create $rep
  [ "$status" -ne 0 ]
  echo $output | grep "Création du répèrtoire $rep impossible"
  #test -e $rep
  #rm -Rf $rep
}

@test "  -> rep is created" {
  rep=$BATS_TMPDIR/test_rep_created
  run sflib_std_rep_create $rep
  echo "status= $status"
  [ $status -eq 0 ]
  test -e $rep
  rm -Rf $rep
}

@test "  -> rep is created with 777 permissions" {
  rep=$BATS_TMPDIR/test_rep_created_with_777
  run sflib_std_rep_create $rep 777
  echo "status= $status"
  [ $status -eq 0 ]
  #rm -Rf $rep
}

@test "DESCRIBE sflib_std_rep_exist" {
  command -v sflib_std_rep_existe
}

@test "  -> return 0 if directory exist" {
  run sflib_std_rep_existe $BATS_TEST_DIRNAME
  [ $status -eq 0 ]
}

@test "  -> return 1 if directory don't exist" {
  dir=/dont/existe
  run sflib_std_rep_existe $dir
  [ $status -eq 1 ]
}
