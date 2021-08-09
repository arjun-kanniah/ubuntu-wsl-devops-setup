#! /usr/bin/bash

read -s -p "Enter your sudo password: " password

SUDO_PASS=$password

# Update & Upgrade apt packages
echo "$SUDO_PASS" | sudo apt update
echo "$SUDO_PASS" | sudo apt upgrade -y

# Update & Upgrade apt-get packages
echo "$SUDO_PASS" | sudo apt-get update
echo "$SUDO_PASS" | sudo apt-get upgrade -y

# INstall pip3 and ansible
echo "$SUDO_PASS" | sudo apt install python3-pip -y
pip3 install ansible --user

git config --global core.autocrlf input

# Create ansible vault token
echo "$SUDO_PASS" > ~/.ansible_vault_pass
echo "$SUDO_PASS" | sudo chmod 0644 ~/.ansible_vault_pass

source ~/.profile

# Install necessary ansible roles and setup ubuntu for devops
ansible-galaxy install -r roles/requirements.yml
ansible-playbook setup_ubuntu.yml --vault-password-file ~/.ansible_vault_pass

# Add local user to docker group
echo "$SUDO_PASS" | sudo usermod -aG docker $USER

# Reload config files
source ~/.bashrc 
source ~/.bash_alias

# Install and setup zsh and oh-my-zsh
echo "$SUDO_PASS" | sudo apt install zsh -y
echo "0" | zsh
echo "$SUDO_PASS" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i "s/robbyrussell/agnoster/" ~/.zshrc
sed -i "s/%n@%m/%n@%m-wsl" ~/.oh-my-zsh/themes/.oh-my-zsh/themes/agnoster.zsh-theme
sed -i "s/%~/%2~/" ~/.oh-my-zsh/themes/.oh-my-zsh/themes/agnoster.zsh-theme
curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors
echo "eval `dircolors ~/.dircolors`" >> ~/.zshrc
echo "$SUDO_PASS" | chsh -s $(which zsh)

# Reload bash profile and config file
source ~/.profile
source ~/.zshrc

zsh
