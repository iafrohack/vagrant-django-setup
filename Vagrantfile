# encoding: utf-8
# This file originally created at http://rove.io/5425949ed379306d0bb17e39ea92f6da

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "v0rtex/xenial64"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.forward_agent = true

  # make sure we share the directory containing Vagrantfile
  config.vm.synced_folder "..", "/vagrant"
  # config.vm.synced_folder `/Users/$USER/work`, "/var/dev/work", create: true

  config.vm.provider :virtualbox do |vb|
     vb.name = "django-playground"
     vb.customize ["modifyvm", :id, "--memory", "768"]
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 5000, host: 9095, auto_correct: true

  config.vm.provision "shell", inline: <<-SHELL
    # make sure our bootstrap script is executable
    sudo chown -R vagrant /vagrant/
    sudo chmod +x /vagrant/vagrant-django-setup/box_bootstrap.sh
    # sudo usermod -a -G sudo vagrant
    # run the provisioning script as vagrant user
    su -c "source /vagrant/vagrant-django-setup/box_bootstrap.sh" vagrant
  SHELL

 #config.vm.provision :shell, path: "box_bootstrap.sh"

end
