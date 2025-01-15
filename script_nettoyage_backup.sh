#!/bin/bash

# Répertoire de sauvegarde sur le serveur distant
remote_server="user@S2"  # Remplacez par l'utilisateur et l'adresse IP ou nom d'hôte du serveur
destination_dir="/path/to/R2"  # Remplacez par le répertoire de sauvegarde sur le serveur distant

# Supprimer les sauvegardes différentielles âgées de plus de 7 jours
ssh $remote_server "find $destination_dir -name 'backup_diff_*' -mtime +7 -exec rm -rf {} \;"

# Supprimer les sauvegardes complètes hebdomadaires (dimanche) âgées de plus de 4 semaines
ssh $remote_server "find $destination_dir -name 'backup_full_*' -mtime +28 -exec rm -rf {} \;"

# Supprimer les sauvegardes mensuelles âgées de plus de 6 mois
ssh $remote_server "find $destination_dir -name 'backup_full_*' -mtime +180 -exec rm -rf {} \;"

echo "Nettoyage des anciennes sauvegardes terminé."

