#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 username"
    exit 1
fi

USERNAME="$1"
NEXT_UID=$(awk -F: '$3>=1000 {uids[$3]=1} END {for(i=1000;i<60000;i++) if(!uids[i]) {print i; break}}' /etc/passwd)
echo "User ID yang akan digunakan: $NEXT_UID"

if grep -q "^$USERNAME:" /etc/group; then
    echo "Grup $USERNAME sudah ada."
else
    echo "$USERNAME:x:$NEXT_UID:" >> /etc/group
    echo "Grup privat '$USERNAME' dibuat dengan GID $NEXT_UID"
fi

read -p "Masukkan komentar/deskripsi user: " COMMENT
echo "Pilih shell (misal: /bin/bash, /bin/sh, /bin/zsh):"
read -p "Shell: " SHELL

if ! grep -qx "$SHELL" /etc/shells; then
    echo "Shell tidak valid. Pilihan harus dari /etc/shells"
    exit 1
fi

read -p "Masukkan tanggal kedaluwarsa akun (format YYYY-MM-DD): " EXPIRY
read -p "Masukkan grup tambahan (dipisah koma, atau kosong): " EXTRA_GROUPS

HOME_DIR="/home/$USERNAME"

echo "$USERNAME:x:$NEXT_UID:$NEXT_UID:$COMMENT:$HOME_DIR:$SHELL" >> /etc/passwd

ENCRYPTED_PASS=$(openssl passwd -6 "Password123!")
EXPIRE_DAYS=$(date -d "$EXPIRY" +%s)
EXPIRE_DAYS=$((EXPIRE_DAYS / 86400))
echo "$USERNAME:$ENCRYPTED_PASS:$(date +%s):0:99999:7:::$EXPIRE_DAYS" >> /etc/shadow

mkdir -p "$HOME_DIR"
chown "$USERNAME:$USERNAME" "$HOME_DIR"
chmod 700 "$HOME_DIR"

if [ -n "$EXTRA_GROUPS" ]; then
    IFS=',' read -ra GROUPS <<< "$EXTRA_GROUPS"
    for group in "${GROUPS[@]}"; do
        if ! grep -q "^$group:" /etc/group; then
            echo "$group:x:$((++NEXT_UID)):" >> /etc/group
            echo "Grup tambahan '$group' dibuat."
        fi
        sed -i "/^$group:/ s/$/,$USERNAME/" /etc/group
    done
fi

echo "User '$USERNAME' berhasil dibuat dengan password default 'Password123!'."
