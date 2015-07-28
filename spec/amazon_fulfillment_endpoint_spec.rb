require 'spec_helper'

describe AmazonFulfillmentEndpoint do

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
    it 'push the order to amazon' do
      stub_request(:any, /mws-eu.amazonservices.com/).to_return(headers: { 'Content-Type': 'text/xml' })
      post '/push_order', WombatPayload.order
      expect(last_response.status).to eql(200)
      expect(json_response["request_id"]).to eql "12e12341523e449c3000001"
      expect(json_response["summary"]).to eq 'The orde was correctly pushed'
    end

  end
end
