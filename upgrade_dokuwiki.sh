#!/usr/bin/env bash
#
# upgrade_dokuwiki.sh
#
# Permit to upgrade multiple dokuwiki installations.
#
# Usage:
#    bash upgrade_dokuwiki.sh URL
# 
# Where URL is the URL from the last tarball of Dokuwiki
# Cf. http://download.dokuwiki.org/
#
# Configuration: Just update the "installations" variable.
# See "YOUR CONFIG" section of the current file.
#
###############################################################################
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
# 
# Copyright (C) 2014 Olivier DOSSMANN 
#  <olivier+upgradedokuwiki@dossmann.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
# 0. You just DO WHAT THE FUCK YOU WANT TO.
#
###############################################################################

#####
## YOUR CONFIG
###
installations="/srv/web/domain/sub/my_dokuwiki
/srv/web/domain/sub2/its_dokuwiki"
file2delete_url="https://github.com/splitbrain/dokuwiki/raw/stable/data/deleted.files"
file2delete_name="deleted.files"
www_user="www-data"
www_group="www-data"

#####
## VARIABLES
###

IFS="
"
red="\e[1;31m"
warning="\e[1;33m"
normal="\e[0m"

#####
## Tests
##

# Check that a param was given
if test $# -ne 1
then
  echo -e "${warning}Missing param: URL${normal}"
  exit 1
else
  url=$1
fi

# Check that curl is here
cmd_curl=`which curl`
if ! test $cmd_curl
then
  echo -e "${warning}CURL command missing${normal}"
  exit 1
fi

# Check if all directories exists
for installation in $installations
do
  if ! test -d $installation
  then
    echo -e "${warning}${installation} is not a directory or is missing. Check your installation directories paths${normal}"
    exit 1
  fi
done

#####
## FUNCTIONS
###

error_and_exit() {
  echo -e "ERROR: ${red}$1${normal}"
  exit 1
}

#####
## START
###

# Create a temporary directory
tmp_dir=`mktemp -d`
current=`pwd`
echo "Temporary directory: ${tmp_dir}"
cd $tmp_dir

# Fetch given URL
remote_file=`basename "$url"`
$cmd_curl -sLo "$remote_file" "$url" || error_and_exit "Dokuwiki download failed!"
echo "Dokuwiki downloaded."

# Extract the tarball
tar xf "$remote_file" || error_and_exit "Dokuwiki extraction failed!"
echo "Dokuwiki extracted"

# Fetch unused files
$cmd_curl -sLo "${file2delete_name}" "${file2delete_url}" || error_and_exit "Deleted file list download failed!"
echo "Deleted files downloaded"

# Browse installations
for installation in $installations
do
  # do a backup
  install_tmp_dir="${tmp_dir}${installation}"
  mkdir -p "$install_tmp_dir"
  echo "Backuping $installation to ${install_tmp_dir}..."
  cp -a "$installation" "$install_tmp_dir" || error_and_exit "Backup failed!"
  echo "Backuped"

  # Copy dokuwiki files into installation
  'cp' -rf dokuwiki/{*,.??*} "$installation" || error_and_exit "Failed to upgrade Dokuwiki files!"
  echo "Dokuwiki files upgraded"

  # Delete old deprecated files
  cd "$installation"
  grep -Ev '^($|#)' "${tmp_dir}/${file2delete_name}" | xargs -n 1 rm -vf || error_and_exit "Failed to delete files"
  # Reset upgrade version message in Dokuwiki
  rm -f "data/cache/messages.txt" || echo -e "${warning}WARNING: Message for upgrading not deleted. Just wait a day to see if it's OK.${normal}"
  # Go back to temporary directory
  cd $tmp_dir
  # Change permissions
  chown ${www_user}:${www_group} "${installation}" -R
done

#####
## END
###
cd $current
exit 0
