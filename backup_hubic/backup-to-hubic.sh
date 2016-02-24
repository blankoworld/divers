#!/bin/bash

###################################
## Backup sur HubiC avec duplicity
# Script sous licence BEERWARE
# Version 0.4.2 02/2016
###################################

set -eu

##### Paramètres

# Utilisateur Hubic
HUBICUSER="leuserdevotrehubic"
# Mot de passe HubiC
HUBICPASSWORD="lemotdepassedevotrehubic"
# Application client id Hubic
HUBICAPPID="api_hubic_XXXXX"
# Application client secret Hubic
HUBICAPPSECRET="YYYYYY"
# Application domaine de redirection Hubic
HUBICAPPURLREDIRECT="http://localhost/"
# Liste à sauvegarder (voir le man duplicity avec le filelist)
DUPLICITYFILELIST="/etc/backup-`hostname`.filelist"
# Passphrase pour le chiffrement
PASSPHRASE="VotrePassPhraseDeOufQueYaQueVousEtVousSeulQuiSavez:-p"
# Fréquence des sauvegardes complètes
FULLIFOLDERTHAN="1W"
# Rétention des sauvegardes
RETENTION="2M"
# Log d'erreur
LOGERROR="/var/tmp/backup-hubic-error.log"
# Bin de duplicity
DUPLICITY_BIN="/usr/bin/duplicity"
# Email pour les erreurs (0 pour désactiver)
EMAIL="david@mercereau.info"
# Envoyer un rapport par email sur l'état des backup
RAPPORT=1
# Log d'erreur
exec 2> ${LOGERROR}

##### Début du script

function cleanup {
	echo "exit..."
	unset CLOUDFILES_USERNAME
	unset CLOUDFILES_APIKEY
	unset PASSPHRASE
        grep -v "has been deprecated" ${LOGERROR} > ${LOGERROR}.tmp
        mv ${LOGERROR}.tmp ${LOGERROR}
	if [ "`stat --format %s ${LOGERROR}`" != "0" ] && [ "$EMAIL" != "0" ] ; then
		cat ${LOGERROR} | mail -s "$0 - Error" ${EMAIL}
	fi
}
trap cleanup EXIT

# Gentil avec le système
ionice -c3 -p$$ &>/dev/null
renice -n 19 -p $$ &>/dev/null

if ! [ -f ${DUPLICITYFILELIST} ] ; then
	echo "Aucun fichier filelist : ${DUPLICITYFILELIST}"
	exit 1
fi

export CLOUDFILES_USERNAME=${HUBICUSER}
export CLOUDFILES_APIKEY=${HUBICPASSWORD}
export CLOUDFILES_AUTHURL="hubic|${HUBICAPPID}|${HUBICAPPSECRET}|${HUBICAPPURLREDIRECT}"
export PASSPHRASE

# Backup 
${DUPLICITY_BIN} --full-if-older-than ${FULLIFOLDERTHAN} / cf+hubic://default --include-filelist ${DUPLICITYFILELIST} --exclude '**'

# Suppression des vieux backups
${DUPLICITY_BIN} remove-older-than ${RETENTION} cf+hubic://default --force

# Rapport sur le backup
if [ "$RAPPORT" != "0" ] && [ "$EMAIL" != "0" ] ; then
        ${DUPLICITY_BIN} collection-status cf+hubic://default | mail -s "$0 - collection-status" ${EMAIL}
fi

unset CLOUDFILES_USERNAME
unset CLOUDFILES_APIKEY
unset PASSPHRASE

exit 0
