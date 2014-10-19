#!/bin/sh

a=ダァ
echo "Original: $a"

n=0
while [ $n -eq 0 ] ; do
    a=シェリイェッス
    echo "inside: $a"
    n=1
done

echo "outside: $a"

