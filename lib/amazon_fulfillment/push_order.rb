require 'peddler'

module AmazonFulfillment
  class PushOrder

    prepend SimpleCommand

    def initialize(order)
      @order = order
    end

    def call
      client.create_fulfillment_order(
        @order['id'],
        @order['id'],
        @order['placed_on'],
        'Standard',
        destination_address,
        items
      )
    end

    private

    def shipping_address
      @order['shipping_address']
    end

    def destination_address
      {
        name: "#{shipping_address.firstname} #{shipping_address.lastname}",
        Line1: shipping_address.address1,
        Line2: shipping_address.address2,
        City: shipping_address.city,
        CountryCode: shipping_address.country,
        StateOrProvinceCode: shipping_address.state,
        PostalCode: shipping_address.zipcode,
      }
    end

    def items
      @order['line_items'].map do |line_item|
        {
          SellerSKU: line_item['product_id'],
          SellerFulfillmentOrderItemId: @order['id'],
          Quantity: line_item['quantity']
        }
      end
    end

    def client
      @client ||= MWS::FulfillmentOutboundShipment::Client.new
    end
  end
end
