#!/bin/bash

set -e

echo "========================================="
echo " PrimaStack OpenStack Deployment"
echo "========================================="
echo

#################################################
# Activate OpenStack environment
#################################################

echo "[1/3] Activating OpenStack environment..."
source openrc.sh

echo
echo "OpenStack environment loaded."
echo

#################################################
# Deploy OpenStack resources
#################################################

echo "[2/3] Deploying OpenStack resources..."
ansible-playbook -i Deploy/ansible/inventory.ini Deploy/ansible/playbooks/install.yml

echo
echo "OpenStack resources deployed."
echo

echo
echo "Waiting 60 seconds before continuing..."

for i in {60..1}; do
    echo -ne "Continuing in $i seconds...\r"
    sleep 1
done

echo
echo "Continuing..."
echo


#################################################
# Configure Zabbix environment
#################################################

echo "[3/3] Configuring Zabbix..."
ansible-playbook -i Deploy/ansible/inventory.ini Deploy/ansible/playbooks/configure.yml

echo
echo "========================================="
echo " Deployment completed successfully"
echo "========================================="
