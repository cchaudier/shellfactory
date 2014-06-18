#!/usr/bin/env bash
trap 'sortie 1' ERR
init() {
  check_root
  sf_version=0.1
  sf_tgz_fic=${sf_version}.tar.gz
  sf_url=https://github.com/cchaudier/shellfactory/archive/$sf_tgz_fic
  sf_tmp_dir=/tmp/shellfactory_install_$RANDOM
  sf_install_dir=/usr/local/shellfactory
  sf_release_dir=${sf_install_dir}/release
  sf_current_dir=${sf_install_dir}/current
  sf_release_name=shellfactory-$sf_version
  sf_env_path=${sf_current_dir}/lib

  rm -rf $sf_tmp_dir && mkdir -p $sf_tmp_dir
  check_prog wget
}

sortie() {
  cr=$1
  rm -rf $sf_tmp_dir
  [ $cr -eq 0 ] && echo "ShellFactory v$sf_version installée dans ${sf_install_dir}"|| erreur "Sortie avec le code $cr"
  exit $cr
}

erreur() {
  msg=$*
  printf "\033[1;31;40m${msg}\033[0m\n"
}

tracef() {
  msg=$*
  printf "\033[1;32;40m --> $msg\033[0m\n"
}

create_arbo() {
  tracef "Création de l'arboresence $sf_install_dir"
  mkdir -p $sf_install_dir
  mkdir -p $sf_release_dir
}

get_release() {
  tracef "Récupération de ShellFactory v$sf_version"
  cd $sf_tmp_dir
  wget $sf_url
}

make_current() {
  tracef "Création du lien release/${sf_release_name}->current"
  cd $sf_release_dir
  tar xzvf $sf_tmp_dir/$sf_tgz_fic >/dev/null
  ln -nfs $sf_release_dir/$sf_release_name $sf_current_dir
}

create_env_var() {
  tracef "Création de la variable d'environnement \$SFLIB"
  export SFLIB=$sf_env_path
  echo "export SFLIB=$sf_env_path">>/etc/environment
}

check_prog() {
  prog=$&
  hash $prog || erreur "$prog n'est pas installé !"
}

check_root() {
  if [ "$UID" -ne 0 ]; then
    erreur "Vous devez être root pour executer ce script"
    sortie 67
  fi
}

init
create_arbo
get_release
make_current
create_env_var
sortie 0
