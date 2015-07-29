require 'peddler'

module AmazonFulfillment
  class PushOrder

    prepend SimpleCommand

    def initialize(order)
      @order = order
      @order_store = OrderStore.new
    end

    def call
      client.create_fulfillment_order(
        @order['id'],
        @order['shipments'][0]['id'],
        @order['placed_on'],
        "Order Number: #{@order['id']}\nThanks for ordering from cellucor.eu!",
        'Standard',
        destination_address,
        items,
        { fulfillment_action: 'Hold' }
      )
      @order_store.add(@order['id'])
    end

    private

    def shipping_address
      @order['shipping_address']
    end

    def destination_address
      {
        name: "#{shipping_address['firstname']} #{shipping_address['lastname']}",
        line1: shipping_address['address1'],
        line2: shipping_address['address2'],
        city: shipping_address['city'],
        country_code: shipping_address['country'],
        state_or_province_code: shipping_address['state'],
        postal_code: shipping_address['zipcode']
      }
    end

    def items
      @order['line_items'].map do |line_item|
        {
          seller_sku: line_item['product_id'],
          seller_fulfillment_order_item_id: line_item['product_id'],
          quantity: line_item['quantity']
        }
      end
    end

    def client
      @client ||= MWS::FulfillmentOutboundShipment::Client.new
    end
  end
end
