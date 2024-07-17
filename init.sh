#!/bin/bash

# get sudo password
sudo -v

# function to check xcode command line tools
install_xcode_tools() {
    if ! xcode-select -p &>/dev/null; then
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install

        # wait for the installation to complete
        echo "Waiting for Xcode Command Line Tools installation to complete..."
        while ! xcode-select -p &>/dev/null; do
            sleep 10
        done
        echo "Xcode Command Line Tools installation completed."
    else
        echo "Xcode Command Line Tools are already installed."
    fi
}

# function to install homebrew
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || {
            echo "Homebrew installation failed."
            exit 1
        }
    else
        echo "Homebrew is already installed."
    fi
}

# function to install ansible
install_ansible() {
    if ! command -v ansible &>/dev/null; then
        echo "Installing Ansible..."
        brew install ansible || {
            echo "Ansible installation failed."
            exit 1
        }
    else
        echo "Ansible is already installed."
    fi
}

# install xcode command line tools
install_xcode_tools

# install homebrew
install_homebrew

# install ansible
install_ansible

# prompt for computer name
echo -n "Enter computer name: "
read -r computer_name

# confirm computer name change
echo "Are you sure you want to change the computer name to '$computer_name'? (y/n)"
read -r confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    # set computer name
    sudo scutil --set ComputerName "$computer_name"
    sudo scutil --set LocalHostName "$computer_name"
    sudo scutil --set HostName "$computer_name"
    echo "Computer name changed to '$computer_name'."
    # flush dns cache
    sudo dscacheutil -flushcache
else
    echo "Computer name change aborted."
    exit 0
fi

# prompt for reboot
echo "Do you want to reboot now? (y/n)"
read -r reboot_confirm

if [[ "$reboot_confirm" == "y" || "$reboot_confirm" == "Y" ]]; then
    sudo reboot
else
    echo "Reboot skipped. Please reboot your system later to apply changes."
fi
