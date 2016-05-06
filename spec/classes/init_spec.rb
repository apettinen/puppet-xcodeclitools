require 'spec_helper'
describe 'XcodeCLI' do

  context 'with default values for all parameters' do
    it { should contain_class('XcodeCLI') }
  end
end
