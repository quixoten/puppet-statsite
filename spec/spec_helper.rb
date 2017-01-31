require "puppetlabs_spec_helper/module_spec_helper"

RSpec.configure do |rspec|
  rspec.default_facts = {
    :osfamily => "Debian",
  }
end
