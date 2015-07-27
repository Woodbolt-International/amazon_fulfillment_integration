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

  describe 'POST /push_order' do
    let(:payload) { '{ "request_id": "12e12341523e449c3000001", "order": {
  "id": "CL574098181",
  "status": "complete",
  "channel": "spree",
  "email": "jarrellmichael@gmaill.com",
  "currency": "USD",
  "placed_on": "2015-07-27T08:14:35Z",
  "updated_at": "2015-07-27T08:14:35Z",
  "totals": {
    "item": 39.99,
    "adjustment": -10,
    "tax": 0,
    "shipping": 12,
    "payment": 41.99,
    "order": 41.99,
    "discount": -10,
    "handling": 0
  },
  "adjustments": [
    {
      "name": "tax",
      "value": 0,
      "code": "TAX"
    },
    {
      "name": "shipping",
      "value": 12,
      "code": "FRT"
    },
    {
      "name": "handling",
      "value": 0,
      "code": "HLD"
    },
    {
      "name": "Nickmercs",
      "value": "-10.0",
      "code": "NICKMERCS"
    }
  ],
  "guest_token": "Q_Xupxd3T62QzzUd92jNNQ",
  "shipping_instructions": null,
  "user_id": 117044,
  "considered_risky": false,
  "line_items": [
    {
      "id": 617512,
      "product_id": "ZMA120-v1.0",
      "name": "ZMA",
      "quantity": 1,
      "price": 39.99,
      "sku": "ZMA120-v1.0",
      "amount": "39.99",
      "discounted_amount": 29.99,
      "taxon": null
    }
  ],
  "payments": [
    {
      "id": 158726,
      "number": 158726,
      "status": "completed",
      "amount": 41.99,
      "payment_method": "Credit Card with Payment Profiles",
      "payment_method_card": "visa",
      "source": {
        "name": "Michael Jarrell",
        "cc_type": "visa",
        "last_digits": "5272",
        "source_type": "Spree::CreditCard"
      }
    }
  ],
  "shipping_address": {
    "firstname": "Michael",
    "lastname": "Jarrell",
    "address1": "5167 Butterfly Lane",
    "address2": "",
    "zipcode": "34288",
    "city": "North Port",
    "state": "FL",
    "country": "US",
    "phone": ""
  },
  "billing_address": {
    "firstname": "Michael",
    "lastname": "Jarrell",
    "address1": "5167 Butterfly Lane",
    "address2": "",
    "zipcode": "34288",
    "city": "North Port",
    "state": "FL",
    "country": "US",
    "phone": ""
  },
  "shipments": [
    {
      "id": "CLH78653584817",
      "order_id": "CL574098181",
      "email": "jarrellmichael@gmaill.com",
      "cost": 12,
      "status": "ready",
      "stock_location": "Cellucor",
      "shipping_method": "2 Days",
      "tracking": null,
      "placed_on": "2015-07-27T08:14:35Z",
      "shipped_at": null,
      "totals": {
        "item": 39.99,
        "adjustment": -10,
        "tax": 0,
        "shipping": 12,
        "payment": 41.99,
        "order": 41.99
      },
      "updated_at": "2015-07-27T03:14:35-05:00",
      "channel": "spree",
      "items": [
        {
          "product_id": "ZMA120-v1.0",
          "name": "ZMA",
          "quantity": 1,
          "price": 39.99
        }
      ],
      "shipping_method_code": "2DA",
      "billing_address": {
        "firstname": "Michael",
        "lastname": "Jarrell",
        "address1": "5167 Butterfly Lane",
        "address2": "",
        "zipcode": "34288",
        "city": "North Port",
        "state": "FL",
        "country": "US",
        "phone": ""
      },
      "shipping_address": {
        "firstname": "Michael",
        "lastname": "Jarrell",
        "address1": "5167 Butterfly Lane",
        "address2": "",
        "zipcode": "34288",
        "city": "North Port",
        "state": "FL",
        "country": "US",
        "phone": ""
      }
    }
  ]
}}' }

    it 'push the order to amazon' do
      stub_request(:any, /mws-eu.amazonservices.com/).to_return(headers: { 'Content-Type': 'text/xml' })
      post '/push_order', payload
      expect(last_response.status).to eql(200)
      expect(json_response["request_id"]).to eql "12e12341523e449c3000001"
      expect(json_response["summary"]).to eq 'The orde was correctly pushed'
    end

  end
end
