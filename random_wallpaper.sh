#!/usr/bin/env bash

# random_wallpaper
#
# Requirement: feh (apt install feh)
# 
# INFO: directory "wallpapers" should exist in your HOME directory.
#       It should also contain pictures

directory="$HOME/wallpapers"
minutes=15

# Some tests
if [ -z "`which feh`" ]; then
  echo "This script needs the feh program. Install it."
i  exit 1
fi

if [ -d '$directory' ]; then
  echo "No $directory found."
  exit 1
fi

IFS="
"

array_files=($(ls -1 $directory))

nb_files=`ls $directory|wc -l`

if [ $nb_files == 0 ]; then
  echo "$nb_files files in $directory"
  exit 1
fi

# initialisation
seconds=$[ $minutes * 60 ]

while true; do

  # Random number generator (not more than files number)
  NUMBER=$[ ( $RANDOM % $nb_files ) ]

  # Change background
  file="${array_files["$NUMBER"]}"
  feh --bg-fill "$directory/$file"

  # Wait some times
  sleep $seconds
done

exit 0
