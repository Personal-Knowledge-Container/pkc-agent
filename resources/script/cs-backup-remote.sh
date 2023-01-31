#!/bin/bash
#
# # run backup script --> must prepare the host file
# 1. MySQL Dump file: /home/ubuntu/cs/mountpoint/backup_restore/mariadb/pkc.pub-2023-01-30-database.sql.gz
# 2. Image Media file: /home/ubuntu/cs/mountpoint/backup_restore/mediawiki/pkc.pub-2023-01-30-images.tar.gz
function prep_vars {
    # echo "Reading values from hosts file into variable"

    rm -f ./temp-out
    touch ./temp-out
    sentence=$(cat ./host-pkcpub-aws)
    for word in $sentence
    do
        echo $word >> temp-out
    done
    export $(cat ./temp-out | grep -v '#' | awk '/=/ {print $1}')
    ansible_host_name=$(head -n 1 ./temp-out)
    # echo $ansible_host_name
    # echo $ansible_connection
    # echo $ansible_ssh_private_key_file
    # echo $ansible_user
    # echo $domain
    # echo $default_transport
    # echo $email
    # echo $pkc_install_root_dir
}

prep_vars
#
#
CMD_VARS="ssh -i $ansible_ssh_private_key_file $ansible_user@$ansible_host_name 'export PATH="$PATH:/usr/local/bin"; cd /$pkc_install_root_dir; ./cs-backup.sh -w /home/ubuntu/cs/mountpoint'"
echo $CMD_VARS
eval $CMD_VARS
#
#
# download result to ../../backup/mariadb
CMD_VARS="ssh -i $ansible_ssh_private_key_file $ansible_user@$ansible_host_name 'ls -t1q /home/ubuntu/cs/mountpoint/backup_restore/mariadb/ | head -n1'"
# echo $CMD_VARS
mysqlfile=$(eval $CMD_VARS)
echo $mysqlfile
scp -i $ansible_ssh_private_key_file $ansible_user@$ansible_host_name:/$pkc_install_root_dir/mountpoint/backup_restore/mariadb/$mysqlfile ./cs/mountpoint/backup_restore/mariadb

# download result to ../../backup/mediawiki
CMD_VARS="ssh -i $ansible_ssh_private_key_file $ansible_user@$ansible_host_name 'ls -t1q /home/ubuntu/cs/mountpoint/backup_restore/mediawiki/ | head -n1'"
mediafile=$(eval $CMD_VARS)
echo $mediafile
scp -i $ansible_ssh_private_key_file $ansible_user@$ansible_host_name:/$pkc_install_root_dir/mountpoint/backup_restore/mediawiki/$mediafile ./cs/mountpoint/backup_restore/mediawiki


# /home/ubuntu/cs/mountpoint/backup_restore/mariadb/
# /home/ubuntu/cs/mountpoint/backup_restore/mariadb/
# wget -O - http://dl.dropbox.com/u/11210438/flockonus-stack.sh | bash
# /home/ubuntu/cs/mountpoint/backup_restore/mediawiki/