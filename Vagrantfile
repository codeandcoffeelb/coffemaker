Vagrant.configure(2) do |config|

  #Define the ubuntu box
  config.vm.box = "ubuntu/trusty64"

  # Name the Vagrant instance
  config.vm.define "CodeAndCoffeeVagrant"

  # Forward our ports
  # 80 for apache, 4000 for jekyll
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 4000, host: 4000

  # Run bootstrap script
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false
end
