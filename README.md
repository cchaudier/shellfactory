#﻿ShellFactory


Travis [![Build
Status](https://travis-ci.org/cchaudier/shellfactory.svg?branch=master)](https://travis-ci.org/cchaudier/shellfactory)
| Drone.io [![Build
Status](https://drone.io/github.com/cchaudier/shellfactory/status.png)](https://drone.io/github.com/cchaudier/shellfactory/latest)
| Codeship.io [ ![Codeship Status for
cchaudier/shellfactory](https://www.codeship.io/projects/319995d0-22fc-0132-5bba-624a1888457d/status)](https://www.codeship.io/projects/36618)

## Qu'est-ce que c'est ?

**ShellFactory** est une bibliothèque de fonctions pour scripts shell. Elle permet d'améliorer votre productivité et la robustesse de vos scripts.

## Avant-propos

Cette bibliothèque est le fruit de 8 ans d’écriture de scripts d'exploitation et d'administration système. J'ai décidé de toiletter, de moderniser et d'ouvrir le code pour la communauté.

**ShellFactory** est écrit en bash. La compatibilité avec d'autres shells n'est pas assuré mais si cela vous intéresse de travailler avec moi sur ce point alors n’hésitez pas à m'envoyer un petit mail. C'est avec plaisir que nous étendrons ensemble la compatibilité.

## Organisation

Le répertoire lib contient les fichiers formant le cœur de la bibliothèque. Les fonctions sont regroupés par thématiques. Chaque fichier est nommé avec 3 lettres et l’extension .lib.
* log.lib : fonctions dédié aux traces
* sdt.lib : fonctions utilitaires standards

Le répertoire test contient les tests unitaires. J'utilise bats pour tester les fonctions. Chaque .lib a un fichier .bats associé. 

## Installation
Avant d'installer **ShellFactory** assurez-vous d'avoir *curl* et *wget* d'installer sur votre machine.

Pour installer **ShellFactory** lancer dans un terminal :

    curl -L https://raw.githubusercontent.com/cchaudier/shellfactory/master/install.sh > /tmp/sf_install.sh && bash /tmp/sf_install.sh ; rm -f /tmp/sf_install.sh
L'installation peut se faire de deux manière :
* global : dans ce cas **ShellFactory** s'installe dans /usr/local/lib/shellfactory via sudo et modifie le fichier /etc/environnement pour y déclarer la variable $SFLIB.
* local : dans ce cas **ShellFactory** s'installe dans ~/.shellfactory, il vous faudra modifier votre profile (~/.bash_profile, ~/.bashrc, ~/.zshrc etc.) avec la ligne suivante :

    export SFLIB=/home/vagrant/.shellfactory/current/lib

Pour tester l'installation vous pouver executer dans un terminal :

    . $SFLIB/log.lib
    trace test_sflib

Vous aurrez alors le resultat suivant :

    I|140618_15h35m47 : [*] test_sflib

## Utilisation
    
Dans vos shells il suffit sourcer les bibliothèques que vous voulez utiliser comme ceci :
    
    . $SFLIB/std.lib

Après avoir sourcé une bibliothèque il faut appeler la fonction d'initialisation sflib_[lib]_init (par exemple sflib_std_init pour la bibliothèque standard)

Ou avec le code suivant :

    #Chargement des bibliothèques
    charge_libs()
    {
        libs="log std"
        for lib in $libs; do
            . ${SFLIB}/${lib}.lib || erreur "Chargmenent de la bibliothèque [$lib] : impossible "
            sflib_log_debug "Chargmenent de la bibliothèque [$lib] : OK"
            sflib_${lib}_init || "Initialisation de la bibliothèque [$lib] : impossible "
            sflib_log_debug "Initialisation de la bibliothèque [$lib] : OK"
            done
     }

### Fonctions obligatoires

Pour fonctionner **ShellFactory** appelle des fonctions que vous devez définir dans vos scripts. Voici la liste et leur description :
* sortie : c'est la fonction de sortie de votre script, elle doit appeler les fonctions de sorties des bibliothèques que vous utilisez (sflib_[lib]_sortie), nettoyer l'environnement temporaire du script (effacer les répertoires et fichiers temporaire, décharger les variables d’environnements définis dans le script, etc.) et renvoyer le code retour adapté.
