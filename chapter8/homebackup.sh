#!/bin/bash

BACKUP_DIR="/var/backups"
HOME_DIR="$HOME"
FULL_BACKUP="${BACKUP_DIR}/full_backup.tar"
INCR_BACKUP="${BACKUP_DIR}/incremental_backup.tar"
SNAPSHOT_FILE="${BACKUP_DIR}/backup.snar"

if [ $# -ne 0 ]; then
    echo "Program bash script homebackup.sh hanya bisa dijalankan tanpa argumen"
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Membuat direktori backup di $BACKUP_DIR"
    sudo mkdir -p "$BACKUP_DIR"
    sudo chown "$USER" "$BACKUP_DIR"
fi

FREE_SPACE_KB=$(df "$BACKUP_DIR" | awk 'NR == 2 {print $4}')
REQUIRED_SPACE_KB=500000

if [ "$FREE_SPACE_KB" -lt "$REQUIRED_SPACE_KB" ]; then
    echo "Tidak cukup ruang di $BACKUP_DIR. Dibutuhkan minimal 5000 MB."
    exit 1
fi

echo "Backup penuh atau incremental? (ketik: full / incr)"
read -r BACKUP_TYPE

if [ "$BACKUP_TYPE" = "full" ]; then
    echo "Melakukan backup full atau backup secara keseluruhan"
    tar --create --verbose --preserve-permissions \
        --file="$FULL_BACKUP" \
        --listed-incremental="$SNAPSHOT_FILE" "$HOME_DIR"
    BACKUP_FILE="$FULL_BACKUP"

elif [ "$BACKUP_TYPE" = "incr" ]; then
    # Cek apakah full backup ada
    if [ ! -f "$FULL_BACKUP" ]; then
        echo "Belum ada backup full. Backup full akan dilakukan."
        tar --create --verbose --preserve-permissions \
            --file="$FULL_BACKUP" \
            --listed-incremental="$SNAPSHOT_FILE" "$HOME_DIR"
        BACKUP_FILE="$FULL_BACKUP"
    else
        # Cek umur backup penuh
        ONE_WEEK_AGO=$(date -d "7 days ago" +%s)
        BACKUP_TIME=$(stat -c %Y "$FULL_BACKUP")

        if [ "$BACKUP_TIME" -lt "$ONE_WEEK_AGO" ]; then
            echo "Backup full lebih dari seminggu yang lalu. Backup full baru akan dibuat."
            tar --create --verbose --preserve-permissions \
                --file="$FULL_BACKUP" \
                --listed-incremental="$SNAPSHOT_FILE" "$HOME_DIR"
            BACKUP_FILE="$FULL_BACKUP"
        else
            echo "Melakukan backup incremental."
            tar --create --verbose --preserve-permissions \
                --file="$INCR_BACKUP" \
                --listed-incremental="$SNAPSHOT_FILE" "$HOME_DIR"
            BACKUP_FILE="$INCR_BACKUP"
        fi
    fi
else
    echo "Input tidak valid. Hanya menyediakan opsi ‘full’ atau ‘incr’."
    exit 1
fi

echo "Mengompresi file backup (harap tunggu)."
gzip -f "$BACKUP_FILE"

# Update variabel BACKUP_FILE menjadi file hasil kompresi
BACKUP_FILE="${BACKUP_FILE}.gz"

SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo "Backup berhasil. Ukuran file backup: $SIZE"
