#! /usr/bin/bash

read -s -p "Enter your sudo password: " SUDO_PASS

echo "$SUDO_PASS" | sudo apt update
echo "$SUDO_PASS" | sudo apt upgrade -y

echo "$SUDO_PASS" | sudo apt-get update
echo "$SUDO_PASS" | sudo apt-get upgrade -y

echo "$SUDO_PASS" | sudo apt install python3-pip -y
pip3 install ansible --user

ansible-galaxy install -r roles/requirements.yml