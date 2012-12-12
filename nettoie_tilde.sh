#!/bin/bash -
#
# nettoie_tilde.sh
#
# Permet de nettoyer les fichiers temporaires 'fichier~' comportant un tilde en
#+ fin de chaîne dans le dossier courant
#
# TODO:
#+ - nettoyage récursif dans un dossier donné suivant le paramètre DONNÉE : -r
#+ - nettoyage selon des mots clés : tilde pour les ~, pyc pour les .pyc, vim 
#+   pour les .swp, etc.
#+ - Utiliser FIND au lieu de LS
#+ - Prendre en compte le cas où LS *~ donne rien et fait une erreur (FIND)

dossier=`pwd`
IFS="
"

for i in `ls $dossier/*~`
do
  echo -e "Suppression de $i…"
  rm -f $i
  echo -e "\t…effectuée avec succès."
done
