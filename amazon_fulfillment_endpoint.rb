require 'sinatra'
require 'bugsnag'
require 'endpoint_base'
require 'time'
require 'dotenv'

Dotenv.load

Bugsnag.configure do |config|
  config.api_key = ENV['BUGSNAG_KEY']
end

Dir['./lib/**/*.rb'].each(&method(:require))

class AmazonFulfillmentEndpoint < EndpointBase::Sinatra::Base
  set :logging, true
  use Bugsnag::Rack

  post '/get_inventory_levels' do
    begin
      AmazonFulfillment::GetInventory.call.result.each do |inventory_level|
        add_object :inventory, {
          id: inventory_level['ASIN'],
          location: 'AMAZON-UK',
          product_id: inventory_level['SellerSKU'],
          quantity: inventory_level['TotalSupplyQuantity']
        }
      end
      result 200, 'The inventory levels was imported correctly'
    rescue Excon::Errors::ServiceUnavailable => e
      result 500, e.response.message
    end
  end

  private

end
