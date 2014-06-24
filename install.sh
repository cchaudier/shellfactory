#!/usr/bin/env bash
trap 'sortie 1' ERR
init() {
  sf_version=0.2
  sf_tgz_fic=${sf_version}.tar.gz
  sf_url=https://github.com/cchaudier/shellfactory/archive/$sf_tgz_fic
  sf_tmp_dir=/tmp/shellfactory_install_$RANDOM
  sf_release_name=shellfactory-$sf_version
  sf_install_dir=/usr/local/lib/shellfactory
  install_type
  sf_release_dir=${sf_install_dir}/release
  sf_current_dir=${sf_install_dir}/current
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
  $SUDO mkdir -p $sf_install_dir
  $SUDO mkdir -p $sf_release_dir
  $SUDO chmod 755 -R $sf_install_dir
}

get_release() {
  tracef "Récupération de ShellFactory v$sf_version"
  cd $sf_tmp_dir
  wget $sf_url
}

make_current() {
  tracef "Création du lien release/${sf_release_name}->current"
  cd $sf_release_dir
  $SUDO tar xzvf $sf_tmp_dir/$sf_tgz_fic >/dev/null
  $SUDO ln -nfs $sf_release_dir/$sf_release_name $sf_current_dir
}

create_env_var() {
  if [ "$SUDO" = "sudo " ]; then
    tracef "Création de la variable d'environnement \$SFLIB"
    export SFLIB=$sf_env_path
    $SUDO cp -p /etc/environment $sf_release_dir/$sf_release_name/environment_sav_$(date '+%Y%m%d_%H%M%S') 
    $SUDO grep -v 'SFLIB' /etc/environment >$sf_tmp_dir/environment_new
    $SUDO echo "SFLIB=$sf_env_path">>$sf_tmp_dir/environment_new
    $SUDO cp -f $sf_tmp_dir/environment_new /etc/environment
  else
    tracef "Modifier votre profile (~/.bash_profile, ~/.bashrc, ~/.zshrc etc.) avec la ligne suivante :
      export SFLIB=$sf_env_path"
  fi
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

install_type() {
  bad_ans=true
  while $bad_ans; do
    echo " Comment voulez vous installer le programme ?  
      1 - local à l'utilisateur (~/.shellfactory)
      2 - global à tous les utilisateurs ($sf_install_name) (nécéssite les droits root)"
    read type
    case $type in
      1) sf_install_dir="$HOME/.shellfactory" && bad_ans=false;;
      2) SUDO="sudo " && bad_ans=false ;;
      *) bad_ans=true ;;
    esac
  done
}

init
create_arbo
get_release
make_current
create_env_var
sortie 0
