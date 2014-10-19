#!/bin/sh

a=ダァ
echo "Original input: $a"

echo 1  |
while read dummy ; do
    a=シェリイェッス
    echo "inside: $a"
done

echo "outside: $a"

