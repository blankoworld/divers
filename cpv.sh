#!/bin/bash
#
# Monte un CDROM, en copie le contenu à l'endroit donné et éjecte le CDROM

destination="/home/olivier/Vidéos"
cdrom_dest="/media/cdrom"
cdrom="/dev/cdrom1"
rouge="\e[1;31m"
jaune="\e[1;33m"
normal="\e[0m"

if ! test -d $destination
then
  echo "Le répertoire de destination n'existe pas!"
  exit 1
fi

mount -t iso9660 -o ro $cdrom $cdrom_dest || echo -e "${jaune}Montage du CDROM échoué${normal}"
rsync -avP $cdrom_dest $destination || (echo -e "${rouge}Échec de la copie${normal}" && exit 1)
umount $cdrom || (echo -e "${rouge}Échec du démontage${normal}" && exit 1)
eject $cdrom || (echo -e "${rouge}Échec de l'éjection${normal}" && exit 1)

echo "Terminé."
exit 0
