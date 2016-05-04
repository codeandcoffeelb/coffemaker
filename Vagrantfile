Vagrant.configure(2) do |config|

  #Define the ubuntu box
  config.vm.box = "ubuntu/trusty64"

  # Name the Vagrant instance
  config.vm.define "CodeAndCoffeeVagrant"

  # Run bootstrap script
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false
end
