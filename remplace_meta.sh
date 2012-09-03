#!/usr/bin/env bash
# 
# remplace_meta.sh
#
# Remplace les caractères accentués par leur équivalents HTML méta

if test $# -ne 1
then
  echo "Aucun fichier donné."
  exit 1
fi

sed -i                 \
  -e 's/œ/\&oelig;/g'  \
  -e 's/è/\&egrave;/g' \
  -e 's/é/\&eacute;/g' \
  -e 's/à/\&agrave;/g' \
  -e 's/ç/\&ccedil;/g' \
  -e 's/ù/\&ugrave;/g' \
  -e 's/ê/\&ecirc;/g'  \
  -e 's/ô/\&ocirc;/g'  \
  -e 's/î/\&icirc;/g'  \
  -e 's/Œ/\&Oelig;/g'  \
  -e 's/É/\&Eacute;/g' \
  -e 's/È/\&Egrave;/g' \
  -e 's/À/\&Agrave;/g' \
  -e 's/Ç/\&Ccedil;/g' \
  -e 's/Ù/\&Ugrave;/g' \
  -e 's/Ê/\&Ecirc;/g'  \
  -e 's/Ô/\&Ocirc;/g'  \
  -e 's/Î/\&Icirc;/g'  \
  $1

echo "Remplacement fini."

exit 0
