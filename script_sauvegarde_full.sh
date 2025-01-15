#!/bin/bash

# Répertoire source (à sauvegarder)
source_dir="/home/louftan/R1"

# Répertoire de destination (sur le même système, en local)
destination_dir="/home/louftan/R2"

# Date actuelle pour créer un répertoire spécifique à cette sauvegarde
date=$(date +"%Y-%m-%d_%H-%M-%S")

# Créer le répertoire de destination avec la date
mkdir -p "$destination_dir/backup_full_$date"

# Commande de sauvegarde complète
rsync -avz --delete "$source_dir/" "$destination_dir/backup_full_$date/"

# Option --delete : supprime les fichiers de destination qui n'existent plus dans la source
echo "Sauvegarde complète terminée."

