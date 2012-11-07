#!/bin/bash
#
# wtf.sh is a program for deleting Windows Thumbs.db Files
#

# utiliser un find plutôt qu'un updatedb && locale
#- => trop lourd
updatedb && locate Thumbs.db > /root/locate_thumbs

cat locate_thumbs | while read fichier ; do
  rm "$fichier"
done

