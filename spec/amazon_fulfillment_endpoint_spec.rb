require 'spec_helper'

describe AmazonFulfillmentEndpoint do
  let(:order_store) { OrderStore.new }

  describe 'POST /get_inventory_levels' do
    context 'when Amazon returns an error response' do
      it 'parses the error' do
        stub_request(:any, /mws-eu.amazonservices.com/).to_raise("An Amazon Error")
        post '/get_inventory_levels', WombatPayload.simple
        expect(last_response.status).to eql 500
        expect(json_response["request_id"]).to eql "12e12341523e449c3000001"
        expect(json_response["summary"]).to eq "An Amazon Error"
      end
    end

    context 'when Amazon returns invetory levels' do
      it 'parses the inventory levels' do
        stub_request(:any, /mws-eu.amazonservices.com/).to_return(
          headers: { 'Content-Type': 'text/xml' },
          body: AmazoneResponse.list_inventory_supply
        )
        post '/get_inventory_levels', WombatPayload.simple
        expect(last_response.status).to eql 200
        expect(json_response["request_id"]).to eql '12e12341523e449c3000001'
        expect(json_response["summary"]).to eq 'The inventory levels was imported correctly'
      end
    end
  end

  describe 'POST /push_order' do
    before do
      stub_request(:any, /mws-eu.amazonservices.com/).to_return(headers: { 'Content-Type': 'text/xml' })
      post '/push_order', WombatPayload.order
    end

    it 'push the order to amazon' do
      expect(last_response.status).to eql(200)
      expect(json_response["request_id"]).to eql "12e12341523e449c3000001"
      expect(json_response["summary"]).to eq 'The order was correctly pushed'
    end

    it 'adds order id to order store' do
      expect(order_store.redis.lrem('orders', 1, 'CL574098181')).to equal(1)
    end
  end

  describe 'POST /get_shipment_info' do
    context 'when Amazon returns an error response' do
      it 'parses the error' do
        stub_request(:any, /mws-eu.amazonservices.com/).to_raise("An Amazon Error")
        post '/get_shipment_info', WombatPayload.simple
        expect(last_response.status).to eql 500
        expect(json_response["request_id"]).to eql "12e12341523e449c3000001"
        expect(json_response["summary"]).to eq "An Amazon Error"
      end
    end

    context 'when Amazon returns an order' do
      it 'parses the shipment info' do
        order_store.add('R574098181')
        stub_request(:any, /mws-eu.amazonservices.com/).to_return(
          headers: { 'Content-Type': 'text/xml' },
          body: AmazoneResponse.order_info
        )
        post '/get_shipment_info', WombatPayload.simple
        expect(last_response.status).to eql 200
        expect(json_response["request_id"]).to eql '12e12341523e449c3000001'
        expect(json_response["summary"]).to eq 'The shipment info was imported correctly'
      end
    end
  end
end
