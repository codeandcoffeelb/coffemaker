Vagrant.configure(2) do |config|

  #Define the ubuntu box
  config.vm.box = "ubuntu/trusty64"

  # Name the Vagrant instance
  config.vm.define "CodeAndCoffeeVagrant"

  # Forward our ports
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Run bootstrap script
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false
end
