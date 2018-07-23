#!/bin/bash
set -e 

DOTFILES_DIR=$(git rev-parse --show-toplevel)
OS_RELEASE=$(cat /etc/*-release | awk -F '[="]' '/^NAME=/ { print $3 }')

# install python-pip for running OS
if [[ "${OS_RELEASE}" == "Arch Linux" ]]; then
  sudo pacman -S --noconfirm python-pip
fi

# create virtualenv so installation won't affect system configuration
pip install --user virtualenv
~/.local/bin/virtualenv dotenv

cd dotenv
. bin/activate
pip install ansible
ansible-playbook ../playbooks/install-tmux.yml -v


deactivate
cd -

