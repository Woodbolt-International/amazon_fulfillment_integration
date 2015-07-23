require 'peddler'

module AmazonFulfillment
  class GetInventory

    prepend SimpleCommand

    def initialize
      @inventory_levels = []
    end

    def call
      parse_inventory_levels
      @inventory_levels
    end

    private

    def parse_inventory_levels(list = inventory_list)
      (list['InventorySupplyList'] || []).each do |inventory_level|
        @inventory_levels << inventory_level
      end
      parse_inventory_list(inventory_list_by_next_token(list['NextToken'])) if inventory_list['NextToken']
    end

    private

    def inventory_list
      client.list_inventory_supply(query_start_date_time: Time.now.utc.iso8601).parse
    end

    def inventory_list_by_next_token(token)
      client.list_inventory_supply_by_next_token(token).parse
    end

    def client
      @client ||= MWS::FulfillmentInventory::Client.new
    end
  end
end
