#!/bin/bash
#
# ambil host file
curl https://raw.githubusercontent.com/Personal-Knowledge-Container/pkc-agent/main/resources/config/host-pkcpub-aws -o host-pkcpub-aws

# run script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Personal-Knowledge-Container/pkc-agent/main/resources/script/cs-backup-remote.sh)"

cd ./cs

# get cs-restore file
curl https://raw.githubusercontent.com/Personal-Knowledge-Container/pkc-agent/main/resources/script/cs-restore.sh -o cs-restore.sh

chmod +x cs-restore.sh

# run restore on local
sh -c "$(curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/Personal-Knowledge-Container/pkc-agent/main/resources/script/cs-auto-restore.sh)"