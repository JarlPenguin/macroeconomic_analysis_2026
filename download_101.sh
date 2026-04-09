#!/bin/bash

for ((i=2004; i<=2025; i++)); do
    for ((j=1; j<=10; j+=3)); do
        if [ $j -lt 10 ]; then
            k=0"$j"
        elif [ $j == 13 ]; then
            k=01
        else
            k=$j
        fi
        if [ $i -lt 2009 ]; then
            ext="zip"
        else
            ext="rar"
        fi
        filename=https://www.cbr.ru/vfs/credit/forms/101-"${i}${k}"01."${ext}"
        wget "$filename" -O file.rar
        if [ $i -lt 2009 ]; then
            unzip -o file.rar *B*.* -d dbf
            unzip -p file.rar *NAMES* > dbf/NAMES_"${k}${i}".dbf
        else
            unar -D -f file.rar *B*.* -o dbf
            unar -D -f file.rar -o - *NAMES* > dbf/NAMES_"${k}${i}".dbf
        fi
    done
done
filename=https://www.cbr.ru/vfs/credit/forms/101-20260101.rar
wget "$filename" -O file.rar
unar -D -f file.rar *B*.* -o data
rm file.rar
