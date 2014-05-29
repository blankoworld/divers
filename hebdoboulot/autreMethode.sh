#! /bin/sh -
#
# autreMethode.sh
#
# Script permettant de calculer la durée de travail effectuée dans une 
#+ entreprise ou ailleurs pour la semaine dont le numéro a été mis en 
#+ paramètre.
# 
# Le script lit les fichiers SemaineXX, où XX est un nombre compris entre 01 et 52.
# Il prend les lignes contenant "Durée du travail" pour faire un total.

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
## FONCTIONS
###

erreur( )
{
	echo "$@" 1>&2
	utilisation_puis_sortie 1
}

utilisation( )
{
	echo "Utilisation: $PROGRAMME [--?] [--help] [--version] fichier"
}

utilisation_puis_sortie( )
{
	utilisation
	exit $1
}

version( )
{
	echo "$PROGRAMME version $VERSION"
}

warning( )
{
	echo "$@" 1>&2
	CODEEXIT=`expr $CODEEXIT + 1`
}

nom_semaine( )
{
	SEMAINE="Semaine inconnue"
	if test -n $1
	then
		fichier=$1
		resultat=`rgrep "=* Semaine.*=*" $fichier`
		SEMAINE=`echo $resultat | sed 's/=*.*\(Semaine.*\)======/\1/g'`
	fi
	return $semaine
}

#####
## VARIABLES
###

# Initialisation des variables
CODEEXIT=0
PROGRAMME=`basename $0`
VERSION=0.0

#####
## VÉRIFICATION PARAMÈTRES
###

while test $# -gt 0
do
	case $1 in
	--help | -hel | --he | --h | '--?' | -help | -hel | -he | -h | '-?' )
		utilisation_puis_sortie 0
		;;
	--version | --versio | --versi | --vers | --ver | -ve | --v | \
	-version | -versio | -versi | -vers | -ver | -ve | -v )
		version
		exit 0
		;;
	-*)
		erreur "Option non reconnue : $1"
		;;
	*)
		break
		;;
	esac
	shift
done

# Enregistrement du premier paramètre entré
fichier=$1

################# À SUPPRIMER DÈS QUE ÇA FONCTIONNE ##################
#echo "Initialisation"
#
#chemin=/home/blanko/RapportHebdomadaire/
#fichier=Semaine

#echo "Vérification"
#echo -e "\tChemin: $chemin"
#echo -e "\tFichier: $fichier"

#rapport=${fichier}${parametre}

#echo -e "\tNotre fichier: $rapport"

#resultat=`rgrep "Durée de travail" ${chemin}${rapport} |cut -d ":" -f 2 |cut -d " " -f 2`

# Multiples tests avant de commencer quoique ce soit

######################################################################

# Multiples tests avant de commencer quoique ce soit
if test -z "$fichier"
then
	erreur Variable fichier vide ou manquante
elif ! test -f "$fichier"
then
	erreur Ceci n\' est pas un fichier
fi

#####
## TRAITEMENT
###

resultat=`rgrep "Durée de travail" $fichier |cut -d ":" -f 2 |cut -d " " -f 2`

total=0
for i in $resultat
do
	total=$((total + i))
done

heures_travail=$((total / 60))
minutes_travail=$((total - (heures_travail * 60)))

duree_travail=${heures_travail}H${minutes_travail}

nom_semaine "$fichier"

echo "$SEMAINE : $total minutes, soit $duree_travail" | tr -s " "

