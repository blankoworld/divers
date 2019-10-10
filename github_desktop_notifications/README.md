# Présentation

Utilise la commande `notify-send` pour afficher sur le bureau les notifications de Github.

# Pré-requis

  * curl
  * libnotify

# Utilisation

## En ligne de commande

```bash
API_KEY=5b10dbc8f77a19f3d8c5a2f0fdaa ./fronde
```

## Via systemd

  * copiez le fichier **fronde** dans votre répertoire personnel&nbsp;: **$HOME/bin**.
  * copiez les fichiers **fronde.service** et **fronde.timer** dans **/etc/systemd/system/**
  * changez **myUser** par le nom de votre utilisateur dans le fichier **/etc/systemd/system/fronde.service**.
  * relancer **systemd** et lancez le timer&nbsp;:
```bash
sudo systemctl daemon-reload
sudo systemctl enable fronde.timer
sudo systemctl start fronde.timer
sudo systemctl start fronde.service
```
