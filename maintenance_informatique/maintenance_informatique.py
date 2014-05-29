#!/usr/bin/env python
#
# maintenance_informatique.py
#
# Programme permettant de calculer le temps dépensé pour chacun des types suivants : 
# - travail de type actif
# - travail de type passif (attente)
# Nous alternons donc entre deux types d'intervalles.

# Copyright (C) 2010 DOSSMANN Olivier
# Auteur : DOSSMANN Olivier
# Courriel : olivier@dossmann.net

from datetime import datetime, timedelta

# Déclaration de variables
ACTIF = "Travail"
PASSIF = "Pause"
activite = ACTIF # variable pour affichage
saisie = ""
periodes = []
longueur_tableau = 0
travail = False # True = travail réel (actif), False = travail dit "simple" (passif)
actif = []
passif = []
total_actif = timedelta(0)
total_passif = timedelta(0)

#Débogage
debug = False
deboggage = False

# Fonction de débogage
def debug(texte):
  """Affiche la chaîne de caractère reçue si le programme est en mode debogage"""
  if deboggage == True:
    print(str(texte))

## Fonctions
def somme(i, j):
  return i+j

## Début du programme principal
# controle d'entree de boucle
saisie = input("Appuyer sur Entrée pour commencer ou Q pour Quitter.").upper()
print(" DEBUT ".center(60, '-'))
while 1 :
  # On traite les données et arrêtons le programme si l'utilisateur appuie sur la touche Q
  if saisie == "Q":
    # Ajout de la date de fermeture du programme (dernière date)
    periodes.append(datetime.now())

    # calcul de la longueur du tableau
    longueur_tableau = len(periodes)

    # traitement seulement si le tableau contient deux valeurs
    if longueur_tableau > 1:
      # calcul des durées entre deux laps de temps
      for i in range(1, longueur_tableau):
        periode = periodes[i] - periodes[i-1]
        # ajout de la durée en fonction du type de période (pair = passif, impair = actif)
        if i%2 == 0:
          passif.append(periode)
        else:
          actif.append(periode)

        ## DEBUG
        if debug == True:
          minutes, seconds = divmod(periode.seconds, 60) # division des secondes par 60
          print("%02d:%02d" % (minutes, seconds))

      # Calcul de la durée totale de chacun des types de périodes (actives, passives)
      # pour l'actif
      for duree in actif:
        total_actif += duree
      # pour le passif
      for duree in passif:
        total_passif += duree

      # Formatage des données
      # pour l'actif
      actif_min, actif_sec = divmod(total_actif.seconds, 60)
      actif_heures, actif_min = divmod(actif_min, 60)
      # pour le passif
      passif_min, passif_sec = divmod(total_passif.seconds, 60)
      passif_heures, passif_min = divmod(passif_min, 60)
      # Impression des résultats
      print(" FIN ".center(62, '-'))
      print("Actif (total) : %02d heures, %02d minutes et %02d secondes" % (
        actif_heures, actif_min, actif_sec))
      print("Passif (total) : %02d heures, %02d minutes et %02d secondes" % (
        passif_heures, passif_min, passif_sec))
      # Attente que l'utilisateur note
      input("Appuyez sur Entrée pour fermer la fenêtre")

    ## DEBUG
    if debug == True:
      print("Impression tableau : ")
      for laps in periodes:
        print(laps)

    # On quitte le programme
    break

  # Récupération de la date actuelle
  periodes.append(datetime.now())

  # Alternance des intervalles
  if bool(travail):
    travail = False
    activite = PASSIF
    #print('Pause')
  else:
    travail = True
    activite = ACTIF
    #print('Travail intensif')

  ##DEBUG
  debug("longueur tableau : " + str(len(periodes)))
  debug("contenu dernière valeur : " + str(periodes[-1]))

  # Contrôle de sortie de boucle
  saisie = input("[ %s ] Appuyez sur Entrée pour continuer/alterner, sinon tapez Q \
pour quitter." % activite).upper()
