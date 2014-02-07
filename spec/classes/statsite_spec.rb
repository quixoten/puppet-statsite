require 'spec_helper'

describe 'statsite', :type => 'class' do
  it {
    should contain_service('statsite').with('name' => 'statsite')
  }
end
