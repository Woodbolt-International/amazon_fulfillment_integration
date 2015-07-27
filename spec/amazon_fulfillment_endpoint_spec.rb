require 'spec_helper'

describe AmazonFulfillmentEndpoint do
  let(:payload) { '{"request_id": "12e12341523e449c3000001"}' }

  describe 'POST /get_inventory_levels' do
    context 'when Amazon returns an error response' do
      it 'parses the error' do
        stub_request(:any, /mws-eu.amazonservices.com/).to_raise("An Amazon Error")
        post '/get_inventory_levels', payload
        expect(last_response.status).to eql 500
        expect(json_response["request_id"]).to eql "12e12341523e449c3000001"
        expect(json_response["summary"]).to eq "An Amazon Error"
      end
    end

    context 'when Amazon returns invetory levels' do
      it 'parses the inventory levels' do
        stub_request(:any, /mws-eu.amazonservices.com/).to_return(headers: { 'Content-Type': 'text/xml' },
        body: '<?xml version="1.0"?>
<ListInventorySupplyResponse xmlns="http://mws.amazonaws.com/FulfillmentInventory/2010-10-01">
  <ListInventorySupplyResult>
    <InventorySupplyList>
      <member>
        <SellerSKU>SampleSKU1</SellerSKU>
        <ASIN>B00000K3CQ</ASIN>
        <TotalSupplyQuantity>20</TotalSupplyQuantity>
        <FNSKU>X0000000FM</FNSKU>
        <Condition>NewItem</Condition>
        <SupplyDetail/>
        <InStockSupplyQuantity>15</InStockSupplyQuantity>
        <EarliestAvailability>
          <TimepointType>Immediately</TimepointType>
        </EarliestAvailability>
      </member>
      <member>
        <SellerSKU>SampleSKU2</SellerSKU>
        <ASIN>B00004RWQR</ASIN>
        <TotalSupplyQuantity>0</TotalSupplyQuantity>
        <FNSKU>X00008FZR1</FNSKU>
        <Condition>UsedLikeNew</Condition>
        <SupplyDetail/>
        <InStockSupplyQuantity>0</InStockSupplyQuantity>
      </member>
    </InventorySupplyList>
  </ListInventorySupplyResult>
  <ResponseMetadata>
    <RequestId>e8698ffa-8e59-11df-9acb-230ae7a8b736</RequestId>
  </ResponseMetadata>
</ListInventorySupplyResponse>')
        post '/get_inventory_levels', payload
        expect(last_response.status).to eql 200
        expect(json_response["request_id"]).to eql '12e12341523e449c3000001'
        expect(json_response["summary"]).to eq 'The inventory levels was imported correctly'
      end
    end
  end
end
