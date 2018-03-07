  #########################
 ## PROGRAMME MULTISYNC ##
#########################

### À PROPOS ###

Ce programme a été initialemment crée pour synchroniser un site web situé à deux endroits. Mais chacun d'eux diffère de l'autre par certains éléments et articles.

Voilà pourquoi une synchronisation est utile.

### PRÉ - REQUIS ###

Pour que le programme fonctionne il faut (sur l'ordinateur local et le(s) serveur(s) distant(s)) :
- rsync
- ssh (client ou serveur en fonction)
- bash

### DESCRIPTION ###

Ce programme permet de synchroniser un dossier local sur un à plusieurs serveurs distants répertoriés dans la variable 'serveur' du programme.

Puis le programme fait l'inverse, il syncrhonise le dossier distant avec le dossier local.

### UTILISATION ###

##--[[ Première étape ]]--##

Il s'agit tout d'abord de modifier le script afin de renseigner la variable $serveur.

En effet les champs à compléter sont ainsi : 

    serveur[0]="CHAINE_DE_CARACTERE"

Si on ajoute des règles, on doit incrémenter le chiffre de départ. Par exemple avec 3 serveurs, on aurait :

    serveur[0]="CHAINE_DE_CARACTERE"
    serveur[1]="AUTRE_CHAINE"
    serveur[2]="ENCORE_UNE_AUTRE_CHAINE"

CHAINE_DE_CARACTERE est de la forme : 

    ordinateur_local_autorisé:serveur_distant.tld:utilisateur_distant:/dossier/distant/

où : 

- ordinateur_local_autorisé : définit le nom d'hôte de l'ordinateur autorisé à envoyer sur le serveur distant. Note : pour que la synchronisation fonctionne il faut que le script se trouve sur le serveur autorisé et qu'il soit lancé sur ladite machine. (eh oui, le programme ne fait pas le café !)
- serveur_distant.tld : domaine ou IP à laquelle on peut joindre le serveur distant sur lequel synchroniser
- utilisateur_distant : nom de l'utilisateur distant qui permet d'accéder en SSH à la machine distante.
- /dossier/distant/ : adresse absolue du dossier distant à synchroniser avec le dossier local renseigné.

##--[[ Seconde étape ]]--##

Il suffit ensuite de lancer le programme tel que ceci : 

    bash multisynchro.sh /DOSSIER/LOCAL/

où DOSSIER/LOCAL désigne le dossier situé sur l'ordinateur où se lance le programme.

##--[[ Exemple ]]--##

J'utilise un site internet sur mon ordinateur actuel (nommé PosteBureau), à l'adresse /srv/super_site/.
Je voudrais envoyer mon site internet sur le serveur megaserveur.tld où se trouve une copie (ou un dossier vide) à l'adresse /srv/www/.
Pour accéder à la machine (qui possède un serveur ssh), j'utilise l'identifiant suivant : blanko.

Ainsi je renseigne la variable 'serveur' du programme : 

    serveur[0]="PosteBureau:megaserveur.tld:blanko:/srv/www/"

Je lance ainsi la commande suivante : 

    bash multisynchro.sh /srv/super_site/

##--[[ Synchronisation multiple ]]--##

Puisqu'il s'agit de renseigner la variable 'serveur' avec un ensemble de données dont l'une est le nom du serveur actuel, on peut imaginer totalement faire une synchronisation d'un dossier local avec plusieurs sites distants.

Exemple : 

    serveur[0]="PosteBureau:megaserveur.tld:blanko:/srv/www/"
    serveur[1]="PosteBureau:autredomaine.tld:junior:/srv/fichiers_web/"

