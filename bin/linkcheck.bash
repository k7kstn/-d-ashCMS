#!/usr/local/bin/bash

USAGE(){
    echo "usage: linkcheck <dir>"
    exit 1
}
[ "$#" -eq 0 ] && USAGE >&2

ERROR_CHECK(){
    [ "$(echo ${PIPESTATUS[@]} | tr -d ' 0')" = "" ] && return

    echo "$1" >&2
    exit 1
}

dir="$1"
[ -d "$dir" ] ; ERROR_CHECK "no directory"
[ -f "$dir/html" ] ; ERROR_CHECK "no html file"

cat "$dir/html"                   |

### take out  href  or  src  attribute.
grep -o -E ' (href|src)="[^"]+"'  |

### take out  contents  within  double quotes
gawk '-F"' '{print $2}'           |

### remove  duplication
sort -u                           |

while read f ; do
### check existence by curl command if it's an URL  otherwise check within the page.

    if grep -q ':' <<< $f ; then
        curl $f &> /dev/null  || echo $f
    elif  grep -q '^/'  <<< $f ; then
	[ -e "$dir/../$f" ]   || echo $f
    else
	[ -e "$dir/$f" ]   || echo $f
    fi
done

ERROR_CHECK "unknown error"

exit 0

