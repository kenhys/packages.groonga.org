# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  name = "packages.groonga.org"
  config.vm.define(name) do |node|
    node.vm.box = "ubuntu-15.10-x86_64"
    node.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-15.10_chef-provisionerless.box"
    node.vm.network "public_network"
    node.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/playbook.yml"
      ansible.groups = {
        "package-servers" => [name],
      }
      ansible.host_key_checking = false
    end
  end
end
