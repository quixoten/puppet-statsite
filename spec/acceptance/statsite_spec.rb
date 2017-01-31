require "spec_helper_acceptance"

describe "statsite" do
  let(:manifest) {
    <<-PP
      class { 'statsite': }
    PP
  }

  it "should run without errors" do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(result.exit_code).to eq 2
  end

  describe port(8125) do
    it { should be_listening.with("tcp") }
    it { should be_listening.with("udp") }
  end

  describe service("statsite") do
    it { should be_enabled }
    it { should be_running }
  end
end
