#! /usr/bin/env bash
#
# dbpsql.sh
#
# Retourne la liste des bases de données de "template1".
# Explications psql : 
# -c permet de lancer une commande sous forme de requête dans PSQL
# -t permet d'enlever l'entête des colonnes et le nombre de lignes résultant

for i in $(psql template1 -c "SELECT datname from pg_database order by datname;" -t)
do
  echo $i
done

exit 0
