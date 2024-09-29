#!/bin/bash

# File yang berisi daftar email
EMAIL_LIST="email_list.txt"

# Subjek email
SUBJECT="Ini Subyek"

# File html yang berisi isi email
EMAIL_BODY="email.html"

# Alamat pengirim
FROM="Nap Developer <email@gmail.com>"

# Cek apakah file daftar email dan isi email ada
if [[ ! -f "$EMAIL_LIST" ]]; then
    echo "File daftar email tidak ditemukan!"
    exit 1
fi

if [[ ! -f "$EMAIL_BODY" ]]; then
    echo "File isi email tidak ditemukan!"
    exit 1
fi

# Loop melalui setiap email di daftar
while IFS= read -r email; do
    echo "Mengirim email ke: $email"
    mail -s "$SUBJECT" -a "From: $FROM" -a "Content-Type: text/html" "$email" < "$EMAIL_BODY"
    if [[ $? -eq 0 ]]; then
        echo "Email terkirim ke $email"
    else
        echo "Gagal mengirim email ke $email"
    fi
done < "$EMAIL_LIST"
