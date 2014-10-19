#!/bin/sh

bindir=$(dirname $0)
pagedir=$(dirname $0)/../pages
# remote=server.sample.jp
sshinfo="ssh target_ssh_srv-auto"  ### irrecgular SSH port 10022 etc. are pulled from  ~/.ssh/config
remotedir=/home/example/public_html/playpit/dashCMS

# rsync -av --delete --exclude '.*' "$pagedir/" "$remote:/home/example/public_html/playpit/dashCMS"
# rsync -av --port=10022 --password-file=$bindir/ssh-example --delete --exclude '.*' "$pagedir/" "$remote:/home/example/public_html/playpit/dashCMS"
# rsync -av -e "ssh -p 10022" --delete --exclude '.*' "$pagedir/" "$remote:/home/example/public_html/playpit/dashCMS"

# rsync -av -e "$sshinfo" --delete --exclude '.*' "$pagedir/" "$remote:/home/example/public_html/playpit/dashCMS"
rsync -av -e "$sshinfo" --delete --exclude '.*' --exclude '*~' "$pagedir/" ":$remotedir"

