#﻿ShellFactory


[![Build
Status](https://travis-ci.org/cchaudier/shellfactory.svg?branch=master)](https://travis-ci.org/cchaudier/shellfactory)
[![Build
Status](https://drone.io/github.com/cchaudier/shellfactory/status.png)](https://drone.io/github.com/cchaudier/shellfactory/latest)

## Qu'est-ce que c'est ?

**ShellFactory** est une bibliothèque de fonctions pour scripts shell. Elle permet d'améliorer votre productivité et la robustesse de vos scripts.

## Avant-propos

Cette bibliothèque est le fruit de 8 ans d'ecriture de scripts d'exploitation et d'administration système. J'ai décidé de toilleter, de moderniser et d'ouvrir le code pour la comunautée.

**ShellFactory** est écrit en bash. La compatibilité avec les autres shells n'est pas assuré mais si cela vous interesse de travailler avec moi sur ce point alors n'hesitez pas a m'envoyer un petit mail. C'est avec plaisir que nous étendrons ensemble la compatibilité.

## Organisation

Le répertoire lib contient les fichiers formant le cœur de la bibliothèque. Les fonctions sont regroupés par thématiques. Chaque fichier est nommé avec 3 lettres et l'extention .lib.
* log.lib : fonctions dédié aux traces
* sdt.lib : fonctions utilitaires standards

Le répertoire test contient les tests unitaires. J'utilise bats pour tester les fonctions. Chaque .lib a un fichier .bats associé. 
