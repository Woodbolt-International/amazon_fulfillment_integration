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

  post '/push_order' do
    begin
      AmazonFulfillment::PushOrder.call(@payload['order'])
      result 200, 'The order was correctly pushed'
    rescue Excon::Errors::ServiceUnavailable => e
      result 500, e.response.message
    end
  end

  post '/get_shipment_info' do
    begin
      AmazonFulfillment::GetShipmentInfo.call.result.each do |shipment|
        add_object :shipment, {
          id: shipment['FulfillmentOrder']['DisplayableOrderId'],
          order_id: shipment['FulfillmentOrder']['SellerFulfillmentOrderId'],
          status: shipment['FulfillmentShipment']['member']['FulfillmentShipmentStatus'],
          tracking: shipment['FulfillmentShipment']['member']['FulfillmentShipmentPackage']['member']['TrackingNumber']
        }
      end
      result 200, 'The shipment info was imported correctly'
    rescue Excon::Errors::ServiceUnavailable => e
      result 500, e.response.message
    end
  end
end
