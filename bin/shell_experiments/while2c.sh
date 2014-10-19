#!/bin/sh

n=1
while [ $n -le 5 ] ; do
    echo $n
    n=$(( $n + 1 ))

done   |

while read num ; do
    echo $num $num

done   |

while read num1 num2 ; do
    echo $(( $num1 + $num2 ))
done

