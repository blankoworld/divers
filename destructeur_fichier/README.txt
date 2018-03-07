  ####################################
 ## PROGRAMME DESTRUCTEUR_FICHIERS ##
####################################

### À PROPOS ###

Ce programme a été crée en vue de simplifier la suppression des fichiers 
 supplémentaires fournis dans les mises à jour de divers systèmes de 
gestion de contenus, tels que Dokuwiki par exemple.

### PRÉ - REQUIS ###

Pour que le programme fonctionne il faut :
- sh
- un fichier liste_a_supprimer.txt dument rempli

### DESCRIPTION ###

Ce programme permet de supprimer les fichiers renseignés dans le fichier 
'liste_a_supprimer.txt'.

### UTILISATION ###

Il suffit d'utiliser la commande suivante : 

    sh destructeur_fichiers.sh

Et le programme se lance.

Si vous voulez éviter la confirmation de suppression pour chaque fichier, 
faites : 

    sh destructeur_fichiers.sh -f


