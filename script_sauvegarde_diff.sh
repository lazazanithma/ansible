#!/bin/bash

# Répertoire source et destination pour la sauvegarde locale
source_dir="/home/louftan/R1"
destination_dir="/home/louftan/R2"
date=$(date +"%Y-%m-%d_%H-%M-%S")

# Fichier de journal pour suivre la dernière sauvegarde complète
last_full_backup_file="/home/louftan/last_full_backup.txt"

# Si le fichier de journal n'existe pas, faire une sauvegarde complète
if [ ! -f "$last_full_backup_file" ]; then
    echo "Aucune sauvegarde complète trouvée, exécution d'une sauvegarde complète"
    # Création du répertoire de destination pour la sauvegarde complète
    mkdir -p "$destination_dir/backup_full_$date"
    # Effectuer la sauvegarde complète
    rsync -avz --delete "$source_dir/" "$destination_dir/backup_full_$date/"
    # Mettre à jour le fichier de journal avec la date de la sauvegarde complète
    echo "$date" > "$last_full_backup_file"
else
    # Sinon, effectuer une sauvegarde différentielle
    echo "Effectuer une sauvegarde différentielle"
    # Effectuer la sauvegarde différentielle en utilisant la dernière sauvegarde complète
    rsync -avz --link-dest="$destination_dir/backup_full_$(cat $last_full_backup_file)" "$source_dir/" "$destination_dir/backup_diff_$date/"
    # Mettre à jour le fichier de journal pour la prochaine sauvegarde
    echo "$date" > "$last_full_backup_file"
fi

