require "beaker-rspec"
require "beaker/puppet_install_helper"
require "beaker/module_install_helper"

# Install Puppet on all hosts
install_puppet_agent_on(hosts, options)

# Install module on all hosts
install_module_on(hosts)
install_module_dependencies_on(hosts)

RSpec.configure do |c|
  module_root = File.expand_path("#{__FILE__}/../..")

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
    end
  end
end
