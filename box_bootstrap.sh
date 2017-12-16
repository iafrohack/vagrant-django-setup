#!/usr/bin/env bash

sudo rm /var/lib/apt/lists/lock

# Add vagrant user to the vboxsf group
sudo adduser vagrant vboxsf

sudo chown -R vagrant /var/lib/dpkg/

# Default Shared directory mount Point is /media. We can change it as below
#sudo VBoxControl guestproperty set /VirtualBox/GuestAdd/SharedFolders/MountDir /var/dev/heza_hub
# Make sure Ubuntu is up to date
sudo apt-get -y update
# sudo apt-get -y upgrade

sudo rm /var/lib/apt/lists/lock

# Setup Python
sudo apt-get install -y python3
sudo apt-get install -y python3-pip
sudo apt-get install -y build-essential libssl-dev libffi-dev

sudo rm /var/lib/apt/lists/lock

# configure virtual environment
# pip3 install  virtualenvwrapper
#pip3 install --upgrade virtualenvwrapper

sudo cat /vagrant/vagrant-django-setup/box_boot.sh > ~/.profile
sudo cat /vagrant/vagrant-django-setup/.bash_aliases >> ~/.profile
