#!/usr/bin/env bash

#Welcome the user
echo "Welcome to the Code And Coffee Long Beach vagrant!"
echo "We are now provisioning the vagrant box..."

#Remove Non-interactive .bashrc lines
echo "Modifying .bashrc to allow edits"
sed '5,10d;' /home/vagrant/.bashrc > /home/vagrant/.bashrcNew
mv /home/vagrant/.bashrcNew /home/vagrant/.bashrc

#Update The Distro
sudo apt-get update

#Download things for Npm and Ruby(Compass and things)
sudo apt-get install -y git build-essential libssl-dev git-core curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev vim apache2

#Install apache2

# Replace apache dir.conf, enable apache php
sudo cp /vagrant/vagrantConfig/dir.conf /etc/apache2/mods-enabled/dir.conf

#Restart apache
sudo service apache2 restart

#Set our document root so we can access it
sudo cp /vagrant/vagrantConfig/000-default.conf /etc/apache2/sites-available/000-default.conf

#Restart apache
sudo service apache2 restart

#Allow .htaccess overrides
sudo cp /vagrant/vagrantConfig/apache2.conf /etc/apache2/apache2.conf
sudo a2enmod rewrite
sudo apache2ctl configtest

#Own the html directory by www-data
sudo chown -R vagrant:www-data /vagrant/html
sudo chmod -R 755 /vagrant/html

#Restart apache for the permissions change
sudo service apache2 restart

#Install NVM (Node Version Manager)
curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | sh
source /home/vagrant/.bashrc

#Install Node (Latest LTS on 4/23/16)
nvm install 4.4.3
nvm use 4.4.3
node -v
nvm alias default 4.4.3

#Install npm without sudo
curl https://raw.githubusercontent.com/glenpike/npm-g_nosudo/master/npm-g-nosudo.sh | sh < /vagrant/npmNoSudoInput.txt
source /home/vagrant/.bashrc

#Install RbEnv
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source /home/vagrant/.bashrc

#Use RBEnv To install Ruby (Latest on 4/23/16)
rbenv install -v 2.3.0
rbenv global 2.3.0

#ensure it installed
ruby -v

#ruby gem tweaking
echo "gem: --no-document" > ~/.gemrc
gem install bundler

#Install Rails
gem install rails
rbenv rehash
rails -v

#INstall compass
gem install compass
rbenv rehash

#Install Jekyll
gem install jekyll
rbenv rehash

#Install Bundler
gem install bundle
rbenv rehash

#Update npm, Install grunt and bower with npm
npm install -g npm
npm install --global bower grunt-cli
bower --version
grunt --version

#Add our awesome ubuntu banner
sudo cp /vagrant/vagrantConfig/sshd_config /etc/ssh/sshd_config
sudo cp /vagrant/vagrantConfig/issue.net /etc/issue.net
sudo cp /vagrant/vagrantConfig/issue.net /etc/motd

#Finished!

#Salutations to the user
echo "Thank you for using the Code And Coffee Long Beach Vagrant!"
echo "Have a nice day!"
