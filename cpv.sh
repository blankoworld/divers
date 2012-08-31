#!/bin/bash
#
# Monte un CDROM, en copie le contenu à l'endroit donné et éjecte le CDROM

destination="/mnt/hd/Vrokai/videotheque"
cdrom_dest="/media/cdrom"
cdrom="/dev/cdrom1"

if ! test -d $destination
then
  echo "Le répertoire de destination n'existe pas!"
  exit 1
fi

mount -t iso9660 -o ro $cdrom $cdrom_dest || echo "Montage du CDROM échoué"
rsync -avP $cdrom_dest $destination || echo "Échec de la copie"
umount $cdrom || echo "Échec du démontage"
eject || echo "Échec de l'éjection"

echo "CDROM copié avec succès"
exit 0
