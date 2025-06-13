#!/bin/bash

# Mengecek apakah argumen file diberikan
if [ $# -ne 1 ]; then
    echo "Program Bash Script $0 hanya memproses 1 file"
    echo "Program menolak memproses file lebih dari 1: $1, $2"
    exit 1
fi

FILE="$1"

# Mengecek apakah file benar-benar ada
if [ ! -f "$FILE" ]; then
    echo "File '$FILE' tidak ditemukan."
    exit 1
fi

# Menampilkan menu dengan here document
cat << EOF
Pilih metode kompresi:
1) gzip
2) bzip2
3) compress
4) zip
EOF

# Baca pilihan dari pengguna
read -p "Masukkan pilihan [1-4]: " pilihan

case "$pilihan" in
    1)
        gzip "$FILE"
        echo "File telah dikompres dengan gzip."
        ;;
    2)
        bzip2 "$FILE"
        echo "File telah dikompres dengan bzip2."
        ;;
    3)
        compress "$FILE"
        echo "File telah dikompres dengan compress."
        ;;
    4)
        zip "${FILE}.zip" "$FILE"
        echo "File telah dikompres dengan zip."
        ;;
    *)
        echo "Pilihan tidak valid."
        exit 1
        ;;
esac

