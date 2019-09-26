#!/bin/bash

# warning: don't forget '/' at the end
dir="/etc/nginx/sites-enabled/"

grep -rEh "server_name" ${dir}*| grep -vE "#.*" | sed -e 's/server_name//g' -e 's/^[[:blank:]]*\(.*\);/\1/g'|sort -u
