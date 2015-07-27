require 'peddler'

module AmazonFulfillment
  class PushOrder

    prepend SimpleCommand

    def initialize
    end

    def call
    end

    private

    def client
      @client ||= MWS::FulfillmentInventory::Client.new
    end
  end
end
