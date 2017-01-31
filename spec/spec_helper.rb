require "puppetlabs_spec_helper/module_spec_helper"

RSpec.configure do |rspec|
  rspec.default_facts = {
    :operatingsystem        => "Ubuntu",
    :operatingsystemrelease => "14.04"
  }
end
