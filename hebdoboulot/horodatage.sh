#! /bin/sh -
#
# horodatage.sh
#
# Script permettant de calculer la durée de travail effectuée dans une 
#+ entreprise ou ailleurs pour la ou les semaines dont le numéro a été 
#+ mis en paramètre.
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
	echo "Utilisation: $PROGRAMME [--?] [--help] [--version] dossier base num_semaines"
	echo -e "\tdossier: Adresse du dossier contenant les fichiers"
	echo -e "\tbase: nom donné aux fichiers, par exemple si les fichiers sont du type \
	Semaine42, alors base = Semaine"
	echo -e "\tsemaines: numéro des semaines voulues"
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

verif_fic( )
{
	if ( test "`ls $dossier | grep \"^${base}..\" | wc -l`" -eq 0)
	then
		SORTIE=1
		return 1
	elif ! test -f "${dossier}/$1"
	then
		SORTIE=2
		return 2
	fi
	SORTIE=42
	return 42
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
	return 42
}

#####
## VARIABLES
###

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

# On test le nombre de paramètres
if ! test $# -gt 2
then
	erreur Il manque des paramètres.
fi

# Enregistrement des variables dossier et base
dossier="$1"
test $# -gt 0 && shift
base="$1"
test $# -gt 0 && shift
num="$1"

# Batterie de tests autour des valeurs définies
if ! test -d "$dossier"
then
	erreur L\'adresse inscrite n\'est pas un dossier
fi

#####
## DEBUT
###

while test $# -gt 0
do
	num="$1"
	fichier=${base}${num}
	verif_fic "$fichier"
	case $SORTIE in
	"1")
		echo "Aucun fichier ne se nomme $fichier"
		;;
	"2")
		echo "Le fichier $fichier n\'existe pas \!"
		;;
	"42")
		# Initialisation adresse absolue du fichier
		adresse_fichier=${dossier}${fichier}
		# Récupération de la durée totale de travail
		duree_travail_hebdomadaire=`awk -f traitement.awk $adresse_fichier 2> /dev/null`
		# Calcul des heures et minutes en découlant (pour une meilleure visibilité)
		total=$duree_travail_hebdomadaire
		heures_travail=$((total / 60))
		minutes_travail=$((total - (heures_travail * 60)))
		duree_travail=${heures_travail}H${minutes_travail}

		# On met à jour le nom de Semaine du fichier (var SEMAINE)
		nom_semaine "$adresse_fichier"

		# On affiche le résultat pour la semaine
		echo "$SEMAINE : $total minutes, soit $duree_travail" | tr -s " "
		;;
	esac
	shift
done

#####
## FIN
###

# Limite le code de retour aux valeurs classiques d'Unix (vu dans Script Shell 
#+ chez O'Reilly)
test $CODEEXIT -gt 125 && CODEEXIT=125

exit $CODEEXIT
