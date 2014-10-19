#!/bin/sh

USAGE(){
    echo "usage: linkcheck <dir>"
    exit 1
}
[ "$#" -eq 0 ] && USAGE >&2


### bash  $PIPESTATUS , zsh  $pipestatus  substitute in POSIX shell
# reference:   http://qiita.com/richmikan@github/items/44cbbde02bd130b2d910

run() {
  local a j k l com # This is out of POSIX specification
  j=1
  while eval "\${pipestatus_$j+:} false"; do
    unset pipestatus_$j
    j=$(($j+1))
  done
  j=1 com= k=1 l=
  for a; do
    if [ "x$a" = 'x|' ]; then
      com="$com { $l "'3>&-
                  echo "pipestatus_'$j'=$?" >&3
                } 4>&- |'
      j=$(($j+1)) l=
    else
      l="$l \"\${$k}\"" # modified from original on above Qiita site
    fi
    k=$(($k+1))
  done
  com="$com $l"' 3>&- >&4 4>&-
             echo "pipestatus_'$j'=$?"'
  exec 4>&1
  eval "$(exec 3>&1; eval "$com")"
  exec 4>&-
  j=1
  while eval "\${pipestatus_$j+:} false"; do
    eval "[ \$pipestatus_$j -eq 0 ]" || return 1
    j=$(($j+1))
  done
  return 0
}


ERROR_CHECK(){
    # [ "$(echo ${PIPESTATUS[@]} | tr -d ' 0')" = "" ] && return
    [ `set | grep ^pipestatus | sed '/=0$/d' | wc -l ` -eq 0 ] && return
    # [ `set | grep ^pipestatus | wc -l ` -eq 0 ] && return

    echo "$1" >&2
    exit 1
}

dir="$1"
run [ -d "$dir" ] ; ERROR_CHECK "no directory"
run [ -f "$dir/html" ] ; ERROR_CHECK "no html file"

cat "$dir/html"                   |

### take out  href  or  src  attribute.
grep -o -E ' (href|src)="[^"]+"'  |

### take out  contents  within  double quotes
gawk '-F"' '{print $2}'           |

### remove  duplication
sort -u                           |

while read f ; do
### check existence by curl command if it's an URL  otherwise check within the page.

    # if grep -q ':' <<< $f ; then
    if echo $f | grep -q ':' ; then
        curl $f &> /dev/null  || echo $f
    # elif  grep -q '^/'  <<< $f ; then
    elif  echo $f | grep -q '^/'  ; then
	[ -e "$dir/../$f" ]   || echo $f
    else
	[ -e "$dir/$f" ]   || echo $f
    fi
done

ERROR_CHECK "unknown error"

exit 0

