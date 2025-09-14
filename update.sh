#!/bin/bash

check_full_disk_access() {
    # try to access a protected directory to test full disk access
    if [ -r "/Library/Application Support/com.apple.TCC/TCC.db" ] 2>/dev/null; then
        return 0
    fi
    
    # alternative check: try to read from /System/Library
    if [ -r "/System/Library/LaunchDaemons" ] 2>/dev/null; then
        return 0
    fi
    
    return 1
}

echo "Checking if Terminal.app has full disk access..."
if ! check_full_disk_access; then
    echo "❌ Terminal.app does not have full disk access."
    echo "Please give full disk access to Terminal.app in System Preferences:"
    echo "1. Open System Preferences > Privacy & Security"
    echo "2. Search for 'Full Disk Access'"
    echo "3. Add Terminal.app to the list"
    echo "4. Run this script again"
    exit 1
fi

echo "✅ Terminal.app has full disk access."

###############################################################################
# ANSIBLE SETUP                                                               #
###############################################################################

# Check if Ansible is installed
if ! command -v ansible &> /dev/null
then
    echo "Ansible is not installed. Please install Ansible and try again."
    exit 1
fi

# install ansible requirements
ansible-galaxy install -r requirements.yml

# run ansible update playbook
ansible-playbook playbook.yml --ask-become-pass
