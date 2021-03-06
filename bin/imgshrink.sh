#!/bin/sh -xv

[ -d "$1" ] || exit 1
[ -e "$1/html" ] || exit 1

cd "$1" || exit 1

cp html  html.$$
ls                           |
grep -iE "\.(jpg|png)$"      |
grep -v -iE "_s\.(jpg|png)$" |
while read f ; do
    # s=$(sed 's;\(....\)$;_s&;' <<< $f)     ### bash specific
    s=$(echo $f | sed 's;\(....\)$;_s&;')
    [ -e "$s" ] && continue
    tag='<img[^>]*src="'$f'"[^>]*/>'
    newtag='<a target="_blank" href="'$f'"><img src="'$s'" /></a>'

    convert -auto-orient -geometry 300x300 "$f" "$s"  &&

    # gsed -i "s;$tag;$newtag;g" html
    gsed -i "s;$tag;$newtag;g" html

done

