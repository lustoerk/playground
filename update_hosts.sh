#!/bin/bash

set -e

MASTER_IP=$(terraform output -json | jq -r '.master_ip.value')
WORKER_IPS=$(terraform output -json | jq -r '.worker_ips.value[]')
ANSIBLE_HOSTS_FILE="../ansible/hosts.ini"

# Write the IPs into the Ansible hosts.ini 
cat <<EOF > $ANSIBLE_HOSTS_FILE
[master]
$MASTER_IP ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa_k3s

[workers]
EOF

# Append each worker's IP to the workers group in hosts.ini
for ip in $WORKER_IPS; do
    echo "$ip ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa_k3s" >> $ANSIBLE_HOSTS_FILE
done

echo "Ansible hosts file updated successfully."
