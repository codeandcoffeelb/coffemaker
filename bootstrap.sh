#!/usr/bin/env bash

#Welcome the user
echo ""
echo ""
echo "Welcome to the Code And Coffee Long Beach vagrant!"
echo "We are now provisioning the vagrant box..."
echo ""
echo ""

#Remove Non-interactive .bashrc lines
echo "Modifying .bashrc to allow edits"
sed '5,10d;' /home/vagrant/.bashrc > /home/vagrant/.bashrcNew
mv /home/vagrant/.bashrcNew /home/vagrant/.bashrc

#Update The Distro
sudo apt-get update

#Download things for Npm and Ruby(Compass and things)
sudo apt-get install -y git build-essential libssl-dev git-core curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev vim

#Install RBEnv
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

#Add our awesome ubuntu banner
sudo cp /vagrant/sshd_config /etc/ssh/sshd_config
sudo cp /vagrant/issue.net /etc/issue.net
sudo cp /vagrant/issue.net /etc/motd

#Finished!
