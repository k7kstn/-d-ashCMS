#!/bin/sh

draftdir=$(dirname $0)/../drafts
pagedir=$(dirname $0)/../pages
page=$(basename $1)
dayhms=$(date +%Y%m%d%H%M%S)

[ "${page}" != "" ] &&
[ -d "$draftdir/${page}" ] &&
mv "$draftdir/${page}"  "$pagedir/${dayhms}_${page}"

