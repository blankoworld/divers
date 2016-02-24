# Introduction

Ce script provient du sujet suivant : http://david.mercereau.info/backup-chiffre-avec-duplicity-sur-hubic/

# Dépendances

  * duplicity 0.7.06 (Cf. http://duplicity.nongnu.org/)

Sous [Ubuntu avec du pinning sur la branche xenial](https://help.ubuntu.com/community/PinningHowto) on retrouve [duplicity 0.7.06](http://packages.ubuntu.com/xenial/duplicity) qui installe pyrax.

# Fichier de configuration

Il faut ajouter le fichier **.hubic_credentials** dans votre répertoire $HOME, comme [expliqué dans la documentation de Duplicity](http://duplicity.nongnu.org/duplicity.1.html#sect16).

Le contenu ressemble à ceci : 

```
[hubic]
email = your_email
password = your_password
client_id = api_client_id
client_secret = api_secret_key
redirect_uri = http://localhost/
```

# Conclusion

Il suffit d'adapter le fichier backup-to-hubic.sh pour ajouter votre EMAIL, clé API, etc. (Lisez le sujet initial de David Mercereau pour cela).

Pensez aussi à adapter les liens qui ressemble à ceci (en changeant **default** par le nom donné à votre application dans HubiC) : 

```
cf+hubic://default
```
