#!/bin/bash

# warning: don't forget '/' at the end
dir="/etc/apache2/sites-enabled/"

grep -Eh "Server(Alias|Name)" ${dir}*|sed -e 's/  / /g' -e 's/^\t//g' -e 's/^ //g'|cut -d " " -f 2|sort -u
