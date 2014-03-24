# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.network :forwarded_port, host: 4567, guest: 80
  config.vm.network :forwarded_port, host: 4200, guest: 4200
  config.vm.network "private_network", ip: "192.168.50.1"
  config.vm.provision :shell, inline: "echo I am provisioning..."
end
