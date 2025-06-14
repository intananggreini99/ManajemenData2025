
# Praktikum Manajemen Data  
###Link Laporan Praktikum : https://intip.in/WdiR

## Writing Interactive Scripts & Function on Bash Beginner Guide Modul

# Chapter 8 - Writing Interactive Scripts

### 1. Program: Validasi Usia Konsumsi Alkohol

Program `exercise1.sh` menerima input usia dari user dan menampilkan apakah user diperbolehkan mengkonsumsi alkohol.

#### Logika:
- Memvalidasi input usia (hanya angka).
- Jika usia >= 16 → diperbolehkan minum alkohol.
- Jika usia < 16 → tampilkan berapa tahun lagi user boleh minum alkohol.
- Tambahan: Hitung rata-rata konsumsi alkohol 100 liter/tahun untuk usia 18+.

---

### 2. Program: Kompresi File dengan Pilihan User

Program `exercise2.sh` menerima **1 file** sebagai argumen dan memberikan pilihan kompresi:
- gzip
- bzip2
- compress
- zip

#### Logika:
- Validasi jumlah argumen.
- Validasi file ada.
- Menampilkan menu dengan here document.
- User memilih metode kompresi.
- Menggunakan `case` untuk menentukan proses kompresi.

---

### 3. Program: Backup Otomatis Home Directory

Program `homebackup.sh` melakukan backup home directory ke `/var/backups` dengan opsi:
- Full backup
- Incremental backup

#### Fitur:
- Mengecek jumlah argumen (harus tanpa argumen).
- Mengecek space di direktori backup.
- Memilih tipe backup.
- Backup di-compress.
- Menampilkan ukuran hasil backup.
- Alias: `homebackup`

---

### 4. Program: Menambah User Linux

Program `simple-useradd.sh` menambahkan user baru dengan ketentuan:
- Harus 1 argumen (username).
- Menentukan user ID yang tersedia.
- Membuat private group.
- Meminta informasi user: deskripsi, shell, tanggal kadaluarsa, dan grup tambahan.
- Menulis entri ke `/etc/passwd`, `/etc/group`, `/etc/shadow`.
- Membuat home directory dan mengatur permission.
- Mengatur password default.
- Menambahkan user ke grup tambahan.

---

### 5. Program: Cek File Berdasarkan Input User

Program ini memungkinkan user memasukkan nama file yang ingin diperiksa secara interaktif, bukan dari argumen.

#### Logika:
- Meminta input nama file dari user.
- Menampilkan informasi properti file jika file ditemukan.
- Menampilkan pesan error jika file tidak ditemukan.

---

# Chapter 11 - Functions

### 6. Fungsi printman

Fungsi `printman` mencetak halaman manual ke file simulasi printer.

#### Logika:
- Validasi jumlah argumen.
- Mendukung opsi section number.
- Output disimpan di `/tmp/{command}_manpage.txt`.

---

### 7. Membuat Alias Command OS Lain di Bash

- Membuat direktori `~/BashGuide/chapter11` untuk menyimpan file bash script fungsi.
- Membuat alias bash mirip dengan DOS dan UNIX.
- Memuat otomatis fungsi-fungsi ini di `~/.bashrc`.

---

# Docker Desktop Setup

### Instalasi Docker Desktop dan WSL Ubuntu
- Instal Docker Desktop
- Instal WSL Ubuntu
- Integrasikan WSL dengan Docker

### Instalasi Image Docker
- Postgres
- MySQL
- Ubuntu

### Menjalankan Container
- Postgres container
- PgAdmin container untuk GUI monitoring
- Apache httpd container

### Koneksi Docker PostgreSQL ke PgAdmin

- Setting koneksi via IP Container dan via localhost.
- Membuat dan menghubungkan server PostgreSQL di PgAdmin.

### Deploy Aplikasi Python dengan Docker
- Membuat file `hello-world.py`
- Membuat `Dockerfile`
- Membuat image dan menjalankan container aplikasi

---
