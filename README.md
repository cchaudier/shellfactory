#﻿ShellFactory


Travis [![Build
Status](https://travis-ci.org/cchaudier/shellfactory.svg?branch=master)](https://travis-ci.org/cchaudier/shellfactory)
| Drone.io [![Build
Status](https://drone.io/github.com/cchaudier/shellfactory/status.png)](https://drone.io/github.com/cchaudier/shellfactory/latest)

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

## Utilisation

Affin d'utiliser les bibliothèques dans vos shells définissez d'abord la variable d'environnement SFLIB avec l'emplacement du répertoire lib de **ShellFactory** dans votre fichier .profile (ou autre en fonction de votre shell) comme par exemple :
export SFLIB=/usr/lib/shellfactory/lib
Puis dans vos shells il suffit sourcer les bibliothèques que vous voulez utiliser comme ceci :
    
    . $SFLIB/std.lib

Après avoir sourcé une bibliothèque il faut appeler la fonction d'initialisation sflib_[lib]_init (par exemple sflib_std_init pour la bibliothèque standard)

### Fonctions obligatoires

Pour fonctionner **ShellFactory** appelle des fonctions que vous devez définir dans vos scripts. Voici la liste et leur description :
* sortie : c'est la fonction de sortie de votre script, elle doit appeler les fonctions de sorties des bibliothèques que vous utilisez (sflib_[lib]_sortie), nettoyer l'environnement temporaire du script (effacer les répertoires et fichiers temporaire, décharger les variables d’environnements définis dans le script, etc.) et renvoyer le code retour adapté.
