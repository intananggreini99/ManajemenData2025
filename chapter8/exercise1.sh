#!/bin/bash

# Meminta inputan usia pengguna
echo -n "Masukkan usia Anda: "
read usia

# Validasi input: harus angka bulat positif
if ! [[ "$usia" =~ ^[0-9]+$ ]]; then
    echo "Input tidak valid. Harap masukkan angka bulat positif."
    exit 1
fi

# Logika utama
if [ "$usia" -ge 16 ]; then
    echo "Anda diperbolehkan untuk minum alkohol."

    # Hitung konsumsi bir statistik
    tahun_minum=$((usia - 16))
    konsumsi=$((tahun_minum * 1000))
    echo "Anda telah mengonsumsi sekitar $konsumsi liter alkohol sejak usia $usia tahun dalam kurun waktu konsumsi $tahun_minum tahun."
else
    sisa=$((16 - usia))
    echo "Anda harus menunggu $sisa tahun lagi sebelum boleh minum alkohol secara legal."
fi

