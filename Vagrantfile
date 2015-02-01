# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos-0604-x64"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.4.2/centos64-x86_64-20140116.box"

  config.vm.define "mysql.master" do |mysql|
    mysql.vm.hostname = "mysql.master"
    mysql.vm.network "private_network", ip: "192.168.33.20"
    mysql.vm.provision :shell, :path => "provision-mysql.sh"
  end

  config.vm.define "mysql.slave" do |mysql|
    mysql.vm.hostname = "mysql.slave"
    mysql.vm.network "private_network", ip: "192.168.33.30"
    mysql.vm.provision :shell, :path => "provision-mysql.sh"
  end

  config.vm.define "fabric" do |fabric|
    fabric.vm.hostname = "fabric"
    fabric.vm.network "private_network", ip: "192.168.33.10"
    fabric.vm.provision :shell, :path => "provision-fabric.sh"
  end
  
end
