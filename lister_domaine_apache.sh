#!/bin/bash

grep -Eh "Server(Alias|Name)" /etc/apache2/sites-enabled/*|sed -e 's/  / /g' -e 's/^\t//g' -e 's/^ //g'|cut -d " " -f 2|sort -u
