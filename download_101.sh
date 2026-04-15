#!/bin/bash

for ((i=2013; i<=2025; i++)); do
    for ((j=1; j<=12; j++)); do
        if [ $j -lt 10 ]; then
            k=0"$j"
        else
            k=$j
        fi
        filename=https://www.cbr.ru/vfs/credit/forms/101-"${i}${k}"01.rar
        wget "$filename" -O file.rar
        unar -D -f file.rar *B1*.* -o dbf
        unar -D -f file.rar -o - *NAMES* > dbf/NAMES_"${k}${i}".dbf
    done
done
filename=https://www.cbr.ru/vfs/credit/forms/101-20260101.rar
wget "$filename" -O file.rar
unar -D -f file.rar *B1*.* -o dbf
unar -D -f file.rar -o - *NAMES* > dbf/NAMES_012026.dbf
rm file.rar
