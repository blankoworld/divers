#!/usr/bin/env bash

# Dépendances : 
# - curl
# - jq
# - clé API Gandi v5, en la fournissant via API_KEY

# Utilisation : 
#    API_KEY=5b10dbc8f77a19f3d8c5a2f0fdaa ./maj_domaines_gandi.sh

# Liste des records de domaines à mettre à jour
# Sous la forme exemple.com/records/www/A pour www.exemple.com
# Plusieurs domaines sont possibles
records=(
'exemple.com/records/www/A'
)

# URL de l'API de Gandi v5
GANDI_API_URL="https://dns.api.gandi.net/api/v5/domains/"

# Récupération de l'IP sur la BOX Bouygues
ip=`/usr/bin/curl -s https://mabbox.bytel.fr/api/v1/wan/ip |/usr/bin/jq '.[0].wan.ip.address'`

# Tests
# Si pas de domaines à mettre à jour, on ne fait rien
if ! [ ${#records[@]} -gt 0 ]; then
	echo "Aucun record/domaine fourni !" && exit 1
fi
# Si pas d'IP, on ne fait rien
if [[ -z "$ip" ]]; then
	echo "Pas d'IP trouvée !" && exit 1
fi
# Avons besoin d'une clé API pour Gandi
if [[ -z "$API_KEY" ]]; then
	echo "Clé API Gandi manquante ! Renseignez API_KEY." && exit 1
fi

# Mise à jour des domaines
for rec in "${records[@]}"
do
	url="${GANDI_API_URL}${rec}"
	data='{"rrset_ttl":"1800","rrset_values":['${ip}']}' # Add IP in DATA
	/usr/bin/curl -X PUT -H "X-Api-key: $API_KEY" -H "Content-Type: application/json" -d "${data}" "${url}"
done

echo "" # Retour à la ligne suite au résultat du CURL

# Sortie de programme
exit 0
