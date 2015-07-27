require 'rubygems'
require 'bundler'
require 'json'
require 'webmock/rspec'

Bundler.require(:default, :test)

require File.join(File.dirname(__FILE__), '..', 'amazon_fulfillment_endpoint.rb')
Dir["./spec/support/**/*.rb"].each {|f| require f}

Sinatra::Base.environment = 'test'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    AmazonFulfillmentEndpoint
  end

  def json_response
    JSON.parse(last_response.body)
  end
end
