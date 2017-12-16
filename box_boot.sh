#!/usr/bin/env bash

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# nice terminal colors + show which git branch you are on
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

sudo rm /var/lib/apt/lists/lock

#temporary fix for automatically loading the virtual env
COUNT="$(grep -c API_VIRTUALENV_ALREADY_ADDED /home/vagrant/.bashrc)"

if [ $COUNT -le 0 ]
  then
    echo "About to setup the virtual env for the first time"
    sudo chown -R vagrant /usr/local/bin/
    sudo chown -R vagrant /home/vagrant/.cache/
    sudo pip3 install  virtualenvwrapper
    mkdir -p /vagrant/.virtualenvs
    # when running vagrant up --provision, in order to execute this block,
    # ssh to the vm and remove the string below from /home/vagrant/.bashrc
    echo "# API_VIRTUALENV_ALREADY_ADDED" >> /home/vagrant/.bashrc
    export PROJECT_HOME=/vagrant/
    export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
    source /usr/local/bin/virtualenvwrapper.sh
    mkdir -p /vagrant/django_play
    mkvirtualenv django_play
    workon django_play

    sudo rm /var/lib/apt/lists/lock

    sudo apt-get install -y apache2
    sudo apt-get install -y  apache2-dev
    sudo apt-get install -y libapache2-mod-wsgi-py3
    # sudo apt-get install -y apache2-utils libexpat1 ssl-cert
    #sudo apt-get install -y apache2-bin apache2.2-common apache2-mpm-
    # prefork apache2-utils libexpat1 ssl-cert apache2-dev

    if ! [ -L /var/www ]; then
      rm -rf /var/www
      ln -fs /vagrant /var/www
    fi

    pip3 install django
    pip3 install --upgrade django
    pip3 install djangorestframework
    pip3 install psycopg2
    pip3 install markdown
    pip3 install django-filter
    pip3 install pygments
    pip3 install ipython

    # install mod_wsgi http://modwsgi.readthedocs.io/en/latest/user-guides/quick-installation-guide.html

    wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.5.22.tar.gz
    tar xf 4.5.22.tar.gz
    cd mod_wsgi-4.5.22
    sudo ./configure --with-python=/usr/bin/python3
    sudo make install

    sudo bash -c " echo '

    LoadModule wsgi_module modules/mod_wsgi.so

    WSGIScriptAlias /wsgi-conf /usr/local/www/wsgi-scripts/wsgi-conf.py
    <Directory /usr/local/www/wsgi-scripts>
    Order allow,deny
    Allow from all
    <Files wsgi-conf.py>
    Require all granted
    </Files>
    </Directory>' >> /etc/apache2/apache2.conf "

  else
    echo "Virtual Env already setup, moving on..."
fi

export PROJECT_HOME=/vagrant/
export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
source /usr/local/bin/virtualenvwrapper.sh
workon django_play
source /vagrant/vagrant-django-setup/.bash_aliases

echo "#################### Vagrant logged in successfully ####################"
