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
  rm -Rf $rep
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

@test "DESCRIBE sflib_std_rep_test" {
  command -v sflib_std_rep_test
}

@test "  -> return 0 if directory exist" {
  run sflib_std_rep_test $BATS_TEST_DIRNAME
  [ $status -eq 0 ]
}

@test "  -> return not null if directory don't exist" {
  dir=/dont/existe
  run sflib_std_rep_test $dir
  [ $status -ne 0 ]
}

@test "DESCRIBE sflib_std_fic_existe" {
  command -v sflib_std_fic_existe
}

@test "  -> return 0 if file exist" { 
  file=$BATS_TMPDIR/test_file_exist
  touch $file
  run sflib_std_fic_existe $file
  [ "$status" -eq 0 ]
  rm -f $file
}

@test "  -> return not null if file don't exist" { 
  file=$BATS_TMPDIR/test_file_dont_exist
  run sflib_std_fic_existe $file
  [ "$status" -ne 0 ]
}

@test "DESCRIBE sflib_std_fic_test" {
  command -v sflib_std_fic_test
}

@test "  -> return 0 if file exist" {
  file=$BATS_TMPDIR/test_file_exist
  touch $file
  run sflib_std_fic_test $file
  [ "$status" -eq 0 ]
  rm -f $file
}

@test "  -> return not null if file don't exist" { 
  file=$BATS_TMPDIR/test_file_dont_exist
  run sflib_std_fic_test $file
  [ "$status" -ne 0 ]
}

@test "DESCRIBE sflib_std_fic_create" {
  command -v sflib_std_fic_create
}

@test "  -> return 0 if file is created" {
  file=$BATS_TMPDIR/test_file_exist
  run sflib_std_fic_create $file
  [ "$status" -eq 0 ]
  rm -f $file
}

@test "  -> file is created" {
  file=$BATS_TMPDIR/test_file_exist
  run sflib_std_fic_create $file
  [ "$status" -eq 0 ]
  test -e $file
  rm -f $file
}

@test "  -> return not null if file don't created" { 
  file=/root/test_file_dont_exist
  run sflib_std_fic_create $file
  [ "$status" -ne 0 ]
}

@test "DESCRIBE sflib_std_mv" {
  command -v sflib_std_mv
}

@test "  -> file is moved" {
  file_s=$BATS_TMPDIR/test_file_src
  file_d=$BATS_TMPDIR/test_file_dest
  touch $file_s
  run sflib_std_mv $file_s $file_d
  [ "$status" -eq 0 ]
  ! test -e $file_s
  test -e $file_d
  rm -f $file_d 
}

@test "  -> return not null if file is not moved" {
  file_s=$BATS_TMPDIR/test_file_src
  file_d=/no_rep/test_file_dest
  touch $file_s
  run sflib_std_mv $file_s $file_d
  [ "$status" -ne 0 ]
  test -e $file_s
  rm -f $file_s 
}

@test "DESCRIBE sflib_std_rm" {
  command -v sflib_std_rm
}

@test "  -> file is deleted" {
  file=$BATS_TMPDIR/test_file_rm
  touch $file
  run sflib_std_rm $file
  [ "$status" -eq 0 ]
  ! test -e $file
}

@test "DESCRIBE sflib_std_rep_move" {
  command -v sflib_std_rep_move
}

@test "  -> directory moved" {
  rep_s=$BATS_TMPDIR/test_rep_move_src
  rep_d=$BATS_TMPDIR/test_rep_move_dest
  mkdir -p $rep_s
  mkdir -p $rep_d
  touch $rep_s/file1
  touch $rep_s/file2
  run sflib_std_rep_move $rep_s $rep_d
  [ "$status" -eq 0 ]
  nb_fic_s=$(eval "ls -rc1 $rep_s 2>/dev/null |wc -w")
  nb_fic_d=$(eval "ls -rc1 $rep_d 2>/dev/null |wc -w")
  [ $nb_fic_s -eq 0 ]
  [ $nb_fic_d -eq 2 ]

  rm -Rf $rep_s $rep_d
}

@test "  -> return not null if fonction can't move directory" {
  rep_s==$BATS_TMPDIR/test_rep_move
  mkdir -p $rep_s
  touch $rep_s/file1
  touch $rep_s/file2
  rep_d=/dont/exist_dest

  run sflib_std_rep_move $rep_s $rep_d
  [ "$status" -ne 0 ]
}
