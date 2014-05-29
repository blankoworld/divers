#!/bin/bash -
#
# horodater.sh
#
# Permet d'éditer le fichier d'horodatage de la semaine afin d'y déposer les 
#+ choses effectuées ce jour
#
# Note :
# - FAIT | permettre création du fichier si inexistant
# - FAIT | ouvrir fichier si existant
# - permettre d'ouvrir le numéro de la semaine demandé si un paramètre existe
# - permettre d'ouvrir le numéro de la semaine pour l'année donnée sachant que :
#   - actuel est le nom du dossier de l'année en cours
#   - 2010 est le nom du dossier pour l'année 2010
# - permettre de choisir l'outil d'édition (via une variable et une recherche which)

#####
## VARIABLES
###

dossier="/home/olivier/personnel/horodatage/actuel/"
nom_fic="Semaine"
num_semaine=`date -u +%V`

#####
## TESTS
###

# Vérification de l'existence du fichier de la semaine
chemin=${dossier}${nom_fic}${num_semaine}
if ! [[ -f $chemin ]]
then
  echo "Le fichier '$chemin' n'existe pas ! Création..."
  ce_jour=$(LANG=fr_FR.UTF8 date -u '+%A %d %B %Y' |sed 's/^./\u&/')
  echo -e "====== Semaine $num_semaine ======\n\n===== $ce_jour =====\n\n  * Arrivée à " >> $chemin
  echo -e "\t...terminée."
fi

#####
## DEBUT
###

# Ouverture du fichier
vim + $chemin
