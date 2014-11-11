#!/bin/bash

grep -rEh "server_name" /etc/nginx/sites-enabled/*| grep -vE "#.*" | sed -e 's/  / /g' |sed -e 's/^[ \t]*//' -e 's/[ \t]*$//' -e 's/  / /g' -e 's/;$//g' -e 's/   / /g'|cut -d ' ' -f 2-5|sort -u
