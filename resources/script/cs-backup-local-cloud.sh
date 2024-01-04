#!/bin/bash
#
# download to local installation using ansible
ansible-playbook -i ./resources/config/hosts ./resources/ansible-yml/cs-backup-local-cloud.yml