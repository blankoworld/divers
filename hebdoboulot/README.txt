  ##########################
 ## PROGRAMME HORODATEUR ##
##########################

### À PROPOS ###

Ce programme a été initialement crée pour suivre mes horaires dans les 
différentes entreprises où j'ai passé mes stages.

Il m'a permis de simplifier grandement les calculs des heures passées, 
mais également d'éviter l'utilisation d'interfaces graphiques et de 
gros fichiers volumineux que sont les feuilles de calcul.

### PRÉ - REQUIS ###

Pour que le programme fonctionne il faut :
- sh
- des fichiers nommés Semaine01 contenant des éléments spécifiques

### DESCRIPTION ###

Ce programme permet de calculer le total des heures effectuées chaque semaine 
pour un ensemble de semaines données en paramètres.

### UTILISATION ###

Il suffit d'utiliser la commande suivante : 

    sh horodatage.sh /mondossier/des/horaires Semaine 01 02 03 04 05

Ceci permet de lire le dossier /mondossier/des/horaires contenant un ensemble de fichiers. Le programme lit alors les fichiers nommés Semaine01, Semaine02, Semaine03, Semaine04 et Semaine05.

Pour chaque fichier, le programme va donner un total des heures effectuées.

##--[[ Syntaxe du fichier texte ]]--##

Pour une aide sur la syntaxe du fichier texte, je vous invite à utiliser le fichier 'Semaine15' pour comprendre la syntaxe à utiliser.

##--[[ horodater.sh ]]--#

Ce script permet d'ouvrir le fichier de la semaine courante en partant du principe que : 
- les fichiers sont nommés sous la forme SemaineXX où XX = numéro de la semaine courante
- les fichiers se trouvent dans le chemin renseigné par la variable 'dossier' du script 'horodater.sh'
- vous utilisez VIM pour éditer vos fichiers

Si le fichier n'existe pas, il le crée avec une en-tête pré-remplie pour la semaine courante et le jour courant.

Exemple d'utilisation : 

    mkdir ~/bin
    cp horodater.sh
    echo "export PATH=\"\$PATH:~/bin\"" >> ~/.bashrc
    source ~/.bashrc
    horodater.sh

