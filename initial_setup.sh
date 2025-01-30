#! /usr/bin/bash

read -s -p "Enter your sudo password: " password

SUDO_PASS=$password

# Update & Upgrade apt packages
echo "$SUDO_PASS" | sudo apt update
echo "$SUDO_PASS" | sudo apt upgrade -y

# Update & Upgrade apt-get packages
echo "$SUDO_PASS" | sudo apt-get update
echo "$SUDO_PASS" | sudo apt-get upgrade -y

# Install pip3 and ansible
echo "$SUDO_PASS" | sudo apt install python3-pip -y
echo "$SUDO_PASS" | sudo apt install pipx -y
pipx ensurepath
pipx install ansible

# Git configs
git config --global core.autocrlf input
git config --global user.name "Arjun Kanniah"
git config --global user.email "arjun.kanniah@outlook.com"

# Create ansible vault token
echo "$SUDO_PASS" > ~/.ansible_vault_pass
echo "$SUDO_PASS" | sudo chmod 0644 ~/.ansible_vault_pass

source ~/.profile
echo "$SUDO_PASS" | sudo apt autoremove -y

# Install and Setup Ubuntu for devops
ansible-playbook ~/repos/ubuntu-wsl-devops-setup/setup_ubuntu.yml --vault-password-file ~/.ansible_vault_pass

# Reload config files
source ~/.bashrc 
source ~/.bash_alias
zsh && \
    echo "$SUDO_PASS" | chsh -s $(which zsh) && \
    source ~/.zshrc
