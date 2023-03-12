#!/bin/bash

echo -e "perintah argument: 
[0] == menggunakan perintah bash (script filename)
[1] == base direktori
[2] == tipe file (maksimal 2 value)
[3] == ignore file atau folder (opsional; use "\""./<nama_direktori>"\"")
"
# pisahkan nilai $2 (jenis nama file) jika memiliki koma
if [[ "$2" == *","* ]];
then
    string="$2"

    str_value=${string#*,}
    str_value2=${string%%,*}
else
    str_value="$2"
    str_value2="$2"
fi

# jangan jalankan skrip perintah jika tidak ada
# argument yang diberikan
if [[  "$1" == "" ]] || [[ "$2" == "" ]];
then
    echo "tidak ada perintah argument yang diberikan silahkn tentukan minimal dua argumen"
    exit 1
fi

echo "file diubah:"

IFS=$'\n'; set -f
for fname in $(find $1 -type f -name "*$str_value2" -or -name "*$str_value")
do
    ignore_files="$(echo "$3" | tr "," "\n")"

    str="${fname}"
    value=${str%/*}

    for files in $ignored_files
    do
        if [ "${fname}" == "$value/$files"] || [ "$value" == "$files"];
        then
            continue 2
        fi
    done

    new_fname=$(echo "${fname}" | tr ' ' '_')
    new_fname=$(echo "${new_fname}" | tr '[:upper:]' '[:lower:]')
    new_fname=$(echo "${new_fname}" | tr '-' '_')
    if [ "${fname}" != "${new_fname}" ]
    then
        echo "      ${fname} --> ${new_fname}"
        git "mv" "${fname}" "${new_fname}"
    fi
done
unset IFS; set +f
