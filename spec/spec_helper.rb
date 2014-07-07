require 'rack/test'
include Rack::Test::Methods

def app
  Sinatra::Application # It is must and tell rspec that test it running is for sinatra
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
