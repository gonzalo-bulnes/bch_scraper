require_relative '../app.rb'
require 'spec_helper.rb'

describe 'true' do 
  it "should be true" do
    true.should be_truthy
  end
end
