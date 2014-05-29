BEGIN {
# Initialisation des variables importantes
	totalMin = 0;
}

/Arrivée.*/{
	arriveeJour = 0;
	split($4,heures, "[hH]");
	heure = 0 + heures[1]; # dit à awk de mettre tout le schmilblick en INT
	minutes = 0 + heures[2];
	arriveeJour = 0 + (heure * 60) + minutes;

	## Mode verbeux
	if (verbeux == 1)
	{
		print "\* Arrivée à : " $4;
		print "\tMatin: " arriveeJour;
	}
}

/Pause de.*/{
	departMidi = 0;
	retourMidi = 0;
	split($4, heures, "[hH]");
	heure = 0 + heures[1];
	minutes = 0 + heures[2];
	departMidi = 0 + (heure * 60) + minutes;
	split($6, heures, "[hH]");
	heure = 0 + heures[1];
	minutes = 0 + heures[2];
	retourMidi = 0 + (heure * 60) + minutes;
	
	## Mode verbeux
	if (verbeux == 1)
	{
		print "  Pause : " $4 " | " $6;
		print "\tFinMatin: " departMidi " DebutAprèsMidi: " retourMidi;
	}
}

/Départ à.*/{
	departJour = 0;
	split($4,heures, "[hH]");
	heure = 0 + heures[1];
	minutes = 0 + heures[2];
	departJour = (heure * 60) + minutes;

	# Calcul du total de la journée
	if (departMidi <= 0 || retourMidi <= 0)
	{
		totalDuJour = 0 + departJour - (retourMidi - departMidi) - arriveeJour;
	}
	else
	{
		totalDuJour = 0 + departJour - arriveeJour;
	}

	# Puis enregistrement global
	totalMin += totalDuJour;

	## Mode verbeux
	if (verbeux == 1)
	{
		print "  Départ à : " $4;
		print "\tSoir: " departJour;
		print "\tTotal: " totalDuJour;
		print "Total jusqu'à maintenant :" totalMin;
	}
}

END {
#	printf("Nous obtenons un total de %5d minutes.\n", totalMin);
	print totalMin;
}
