
# vagrant-django-setup

DISCLAIMER: This is my first attempt at setting up
a vagrant box to use in the context of a team.
Room for improvement exists here, feel free to improve
as you see fit.

Goal: Set up an Ubuntu box with Django + Django Rest Framework ready for use,
within virtualenvwrapper.

Guide:

1. Install VirtualBox
2. Install Vagrant
3. Clone/copy this repo anywhere on your machine
4. open your terminal, then cd to the directory you have copied/cloned this repo
5. vagrant up --provision # this will create and boot up your Ubuntu box for the first time. Might take a few minutes.
6. Once #5 finishes, run: vagrant ssh # this will ssh to your new Ubuntu box. The initial setup script will also run and get your dependencies + virtual environment setup.
7. If you want re-run the setup script, delete the string `API_VIRTUALENV_ALREADY_ADDED` from /home/vagrant/.bashrc in your virtual machine, then do vagrant up --provision again.
8. Your machine should be ready at this point. Now run: `workon django_play` to work under your virtual environment.
At this point, you are ready to start playing with django as you please.

Note: With this project, the shared folder between your virtual machine and the host machine,
is the directory that contains the files in this repo.

So, if your have this repo under ~/work/vagrant-django-setup, your virtual machine will have
access to all directories under ~/work. This makes the setup easier, as all directories under
~/work are automatically available to your Ubuntu box.

Now, to setup the django project for e.g, all you need to do is:

cd ~/work
django-admin startproject <name of your project>

Happy coding!
