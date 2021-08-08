#! /usr/bin/bash

read -s -p "Enter your sudo password: " SUDO_PASS

echo "$SUDO_PASS" | sudo apt update
echo "$SUDO_PASS" | sudo apt upgrade -y

echo "$SUDO_PASS" | sudo apt-get update
echo "$SUDO_PASS" | sudo apt-get upgrade -y

echo "$SUDO_PASS" | sudo apt install python3-pip -y
pip3 install ansible --user

git config --global core.autocrlf input

echo "$SUDO_PASS" > ~/.ansible_vault_pass
echo "$SUDO_PASS" | sudo chmod 0644 ~/.ansible_vault_pass

source ~/.profile

ansible-galaxy install -r roles/requirements.yml

ansible-playbook setup_ubuntu.yml --vault-password-file ~/.ansible_vault_pass

source ~/.bashrc