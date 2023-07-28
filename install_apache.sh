#!/bin/bash

# Vérification des privilèges d'administration (root)
if [ "$EUID" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant qu'administrateur (root)."
    exit 1
fi

# Mise à jour des paquets
apt update

# Installation d'Apache
apt install -y apache2

# Démarrage du service Apache
systemctl start apache2

# Activation du démarrage automatique au démarrage du système
systemctl enable apache2

# Vérification de l'état d'Apache
if systemctl is-active --quiet apache2; then
    echo "Apache a été installé avec succès et est en cours d'exécution."
else
    echo "Une erreur s'est produite lors de l'installation d'Apache."
    exit 1
fi

# Obtenir l'adresse IP du serveur Apache
server_ip=$(hostname -I | awk '{print $1}')

echo "Adresse IP du serveur Apache : $server_ip"

echo "Pour modifier vos pages, rendez-vous dans le dossier /var/www/html"
