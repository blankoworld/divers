#!/bin/sh -
#
# destructeur_fichiers.txt
#
# Permet la suppression de la liste de fichiers contenue dans liste_a_supprimer.txt
# Ajoutez -f en paramètre pour supprimer les fichiers sans confirmation.

#####
## LICENCE
###

#                LICENCE PUBLIQUE RIEN À BRANLER
#                      Version 1, Mars 2009
#
# Copyright (C) 2010 Olivier DOSSMANN
#  <blankoworld@wanadoo.fr>
# 
# La copie et la distribution de copies exactes de cette licence sont
# autorisées, et toute modification est permise à condition de changer
# le nom de la licence. 
#
#         CONDITIONS DE COPIE, DISTRIBUTON ET MODIFICATION
#               DE LA LICENCE PUBLIQUE RIEN À BRANLER
#
#  0. Faites ce que vous voulez, j’en ai RIEN À BRANLER.

#####
## VARIABLES
###

CODEEXIT=0
PROGRAMME=`basename $0`
VERSION=0.1

liste="liste_a_supprimer.txt"
force=0 ## pour savoir si on force la suppression ou pas

#####
## VERIFICATION PARAMETRES
###

while test $# -gt 0
do
  case $1 in
    -f )
    force=1 # si on veut supprimer sans confirmer
    ;;
    *)
    break
    ;;
  esac
  shift
done

#####
## DEBUT
###

for i in `cat $liste`
do
  # L'utilisateur veut il supprimer sans confirmation ?
  if test $force -ne 0
  then
    rm -f $i # oui il veut
  else
    rm -i $i # non il ne veut pas
  fi
done

#####
## FIN
###

# Limite le code de retour aux valeurs classiques d'Unix (vu dans Script Shell 
#+ chez O'Reilly)
test $CODEEXIT -gt 125 && CODEEXIT=125

exit $CODEEXIT
