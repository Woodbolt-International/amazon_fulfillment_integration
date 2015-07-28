require 'peddler'

module AmazonFulfillment
  class GetShipmentInfo

    prepend SimpleCommand

    def initialize
      @order_store = OrderStore.new
    end

    def call
      @order_store.all.map do |id|
        @order_store.delete(id)
        client.get_fulfillment_order(id)
      end
    end

    private

    def client
      @client ||= MWS::FulfillmentOutboundShipment::Client.new
    end
  end
end
