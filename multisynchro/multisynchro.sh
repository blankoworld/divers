#!/bin/bash -
#
# multisynchro.sh
# 
# Permet de synchroniser un dossier avec un ou plusieurs serveurs renseigné(s) 
#+ dans la variable $serveur du programme.

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

# Serveurs à synchroniser. Sous la forme suivante (
#+ hostname_d_origine:domaine.tld:utilisateur_ssh:/dossier/a/syncrhoniser/
#+ )
serveurs[0]='mon_ordinateur:mondomaine.net:utilisateur_distant:/dossier/distant//'
#serveurs[1]='autre_ordinateur:autredomaine.com:utilisateur_distant2:/le/dossier/distant/'

# Serveur sur lequel nous sommes
ordinateur_actuel=`hostname`

#####
## FONCTIONS
###

# Basiques

erreur()
{
  echo "Erreur : $@" 1>&2
  utilisation_puis_sortie 1
}

utilisation()
{
  echo "Utilisation : $PROGRAMME [DOSSIER_CIBLE]"
  echo -e "  Permet de synchroniser le dossier local (DOSSIER_CIBLE) avec l'un\
 des serveurs renseigné dans le \n  tableau serveur[*] (contenu dans le \
programme)."
}

utilisation_puis_sortie()
{
  utilisation
  exit $1
}

# Pour le programme

construct_lieu()
{
  echo "  Création du lieu..."
  LIEU="$1@$2:$3"
  echo "    ...terminé."
}

synchronisation()
{
  echo "  Synchronisation..."
  echo "    Envoi vers $2..."
  rsync -av -e ssh $1 $2
  echo "    Envoi vers le dossier local..."
  rsync -av -e ssh $2 $1
  echo "    ...terminée."
}

traitement()
{
  domaine=`echo $1 |cut -d ":" -f 2`
  utilisateur=`echo $1 |cut -d ":" -f 3`
  adresse=`echo $1 |cut -d ":" -f 4`
  construct_lieu $utilisateur $domaine $adresse
  synchronisation $dossier_synchro $LIEU
}

#note_auteur()
#{
#  echo "Note du Blankoworld : Penser à changer le fichier de configuration dans l'administration du site."
#}

#####
## TESTS PRE-LANCEMENT
###

# Test du nombre de variables
if test $# -eq 0
then
        utilisation_puis_sortie
fi

# Dossier local à synchroniser
dossier_synchro="$1"

# Test avant lancement du programme
if test -z $dossier_synchro
then
        erreur Vous devez donner un dossier cible pour effectuer la 
        synchronisation.
elif ! test -d $dossier_synchro
then
        erreur Le paramètre indiqué n\'est pas un dossier ou n\'existe pas.
elif ! [[ $(ls $dossier_synchro |wc -l) -gt 0 ]]
then
        erreur Le dossier semble être vide.
fi

#####
## DEBUT DU PROGRAMME
###

correspondance=0
for serveur in `echo ${serveurs[*]}`
do
        ordi_teste=`echo $serveur |cut -d ":" -f 1`
        if [[ $ordinateur_actuel == $ordi_teste ]]
        then
                let correspondance+=1 # on a trouvé une occurence de l'ordinateur actuel
                echo "Ordinateur trouvé ! Lancement du traitement..."
                traitement $serveur $dossier_synchro # on lance le traitement
                echo "Traitement terminé avec succès."
#                note_auteur
        fi
done

if [[ $correspondance -eq 0 ]]
then
  erreur L\'ordinateur actuel n\'est pas répertorié dans le programme.
fi

exit 1
