require "spec_helper"

describe "statsite", :type => "class" do
  it { should contain_exec("statsite::install::download") }
  it { should contain_exec("statsite::install::extract") }
  it { should contain_exec("statsite::install::compile") }
  it { should contain_file("/opt/statsite/current").with_target("/opt/statsite/statsite-0.6.0") }
  it { should contain_file("/etc/statsite").with_ensure("directory") }
  it { should contain_file("/etc/statsite/config") }
  it { should contain_file("/etc/init.d/statsite") }
  it {
    should contain_service("statsite").with(
      "name"     => "statsite",
      "provider" => "debian",
    )
  }
end
