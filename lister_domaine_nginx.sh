#!/bin/bash

# warning: don't forget '/' at the end
dir="/etc/nginx/sites-enabled/"

grep -rEh "server_name" ${dir}*| grep -vE "#.*" | sed -e 's/  / /g' |sed -e 's/^[ \t]*//' -e 's/[ \t]*$//' -e 's/  / /g' -e 's/;$//g' -e 's/   / /g'|cut -d ' ' -f 2-5|sort -u
