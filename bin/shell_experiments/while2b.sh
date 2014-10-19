#!/bin/sh

n=1
while [ $n -le 5 ] ; do
    echo $n
    n=$(( $n + 1 ))

done   |
while read num ; do
    echo $num $num
done

