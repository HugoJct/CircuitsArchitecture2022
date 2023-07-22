# M1 Circuits et Architecture: Projet

Ce projet a un double but :

-  Câbler dans logisim un micro-processeur qui implante un sous-ensemble des instructions
du micro-processeur LC-3

-  Programmer avec ces instructions un petit jeu de routines.

On distingue deux possibilités de rendu: un projet minimal et un projet avancé, décrits ci-dessous.

## Projet minimal

### Partie câblage:

Implémenter les instructions suivantes:

-  LEA
-  LDR
-  LD
-  ST
-  STR
-  BR
-  JMP
-  SCAN (instruction spécifique à ce projet)

### Partie programmation langage d'assembleur 

Ici deux ensembles de fonctions sont demandés:

- Un ensemble permettant de manipuler les codes de Gray (voir plus bas)
- Un ensemble permettant de manipuler des chaînes de caractères

Chaque fonction doit ici être codée comme un programme à part entière (voir projet avancé)

#### Partie codes de Gray

Implémenter les fonctions suivantes:

- bin2gray, permettant de transformer un codage binaire standard vers un code de Gray
- gray2bin, permettant de transformer un code de Gray vers un codage binaire standard

#### Partie chaînes de caractères

Implémenter les fonctions suivantes:

- **index**: calcule l'adresse de la première occurrence d'un caractère au sein d'une chaîne de caractères (retourne 0 si le caractère n'est pas présent dans la chaîne)

Sémantique:

`index R0, R1, R2` avec R0 le registre de destination, R1 le code du caractère et R2 l'adresse de début de la chaîne de caractère

- **rindex**: calcule l'adresse de la dernière occurrence d'un caractère au sein d'une chaîne de caractères (retourne 0 si le caractère n'est pas présent dans la chaîne)

Sémantique:

`rindex R0, R1, R2` avec R0 le registre de destination, R1 le code du caractère et R2 l'adresse de début de la chaîne de caractère

- **strcmp**: renvoie un entier indiquant la taille de deux chaînes de caractères l'une par rapport à l'autre

Sémantique:

`strcmp R0, R1, R2` avec R0 le registre de destination, R1 l'adresse de début de la première chaîne de caractères et R2 l'adresse de début de la deuxième chaîne de caractères 

- **strcpy**: copie une chaîne de caractères dans une autre

Sémantique:

`strcpy R1, R2` avec R1 l'adresse de début de la chaîne à copier et R2 l'adresse de début de la chaîne de destination

- **strncpy**: copie n caractères d'une chaîne de caractères vers une autre

Sémantique:

`strncpy R0,  R1, R2` avec R0 le nombre de caractères à copier, R1 l'adresse de début de la chaîne source et R2 l'adresse de début de la chaîne de destination.

## Projet avancé

### Partie câblage

Implémenter les instructions suivantes:

- JSR
- JSRR

L'implémentation de ces instructions passe par la modification des modules RegPC et WriteVal.

### Partie programmation langage d'assembleur 

Toutes les fonctions décrites plus haut doivent être implémentées comme des routines qui ne modifient pas d’autres registres que ceux du résultat. Vous pouvez soit utiliser une mémoire de sauvegarde par routine ou implémenter une pile.

## Annexe codage de Gray

`TODO`

## Modalités de rendu

Le rendu du projet est prévu en deux sous-rendus:

- Rendu du **16 décembre 2022 @ 18h**: projet minimal 
- Rendu du **6 janvier 2023 @ 18h**: projet avancé (le plus avancé possible)

Le projet est à rendre sous la forme d'une archive tar contenant:

- Le fichier logisim du LC-3 complété (logisimLC-3-v*.circ)
- Des programmes de test pour chaque instruction complétée
- Des fichiers assembleur contenant le code des routines de rotation
- Un rapport expliquant les choix techniques ayant été faits durant la réalisation du projet, les modification apportées au fichier de base, expliquer pourquoi ces modifications sont pertinentes
