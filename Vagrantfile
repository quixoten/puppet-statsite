# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

puppet_source = <<-SOURCE.gsub(/^\s+/, "")
  deb http://apt.puppetlabs.com/ precise main dependencies
  deb-src http://apt.puppetlabs.com/ precise main dependencies
SOURCE

initialize = <<-SCRIPT
  echo -e "#{puppet_source}" > /etc/apt/sources.list.d/puppet.list
  apt-key adv --keyserver keyserver.ubuntu.com --recv 4BD6EC30
  apt-get update
  apt-get -y install puppet
  puppet apply \
    --modulepath /vagrant/spec/fixtures/modules \
    /vagrant/spec/fixtures/manifests/default.pp
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vagrant|
  vagrant.vm.provision 'shell', :inline => initialize

  vagrant.vm.define 'precise64' do |config|
    config.vm.box = 'puppetlabs-precise64-nocm'
    config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'
  end
end
