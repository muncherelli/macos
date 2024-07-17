#!/bin/bash

# Check if Ansible is installed
if ! command -v ansible &> /dev/null
then
    echo "Ansible is not installed. Please install Ansible and try again."
    exit 1
fi

# run ansible update playbook
ansible-playbook update.yml --ask-become-pass
