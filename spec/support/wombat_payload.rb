module WombatPayload
  class << self
    def simple
      '{"request_id": "12e12341523e449c3000001"}'
    end

    def order
      '{ "request_id": "12e12341523e449c3000001", "order": {
        "id": "R574098181",
        "status": "complete",
        "channel": "spree",
        "email": "spree@spree.com",
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
        "shipping_instructions": null,
        "user_id": 1234,
        "considered_risky": false,
        "line_items": [
          {
            "id": 617512,
            "product_id": "ZMA12",
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
              "name": "Jack Russell",
              "cc_type": "visa",
              "last_digits": "1234",
              "source_type": "Spree::CreditCard"
            }
          }
        ],
        "shipping_address": {
          "firstname": "Jack",
          "lastname": "Russell",
          "address1": "5167 Butterfly Street",
          "address2": "",
          "zipcode": "34288",
          "city": "North Port",
          "state": "FL",
          "country": "US",
          "phone": ""
        },
        "billing_address": {
          "firstname": "Jack",
          "lastname": "Russel",
          "address1": "5167 Butterfly Street",
          "address2": "",
          "zipcode": "34288",
          "city": "North Port",
          "state": "FL",
          "country": "US",
          "phone": ""
        },
        "shipments": [
          {
            "id": "H78653584817",
            "order_id": "R574098181",
            "email": "spree@spree.com",
            "cost": 12,
            "status": "ready",
            "stock_location": "Canada",
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
                "product_id": "ZMA12",
                "name": "ZMA",
                "quantity": 1,
                "price": 39.99
              }
            ],
            "shipping_method_code": "2DA",
            "billing_address": {
              "firstname": "Jack",
              "lastname": "Russell",
              "address1": "5167 Butterfly Street",
              "address2": "",
              "zipcode": "34288",
              "city": "North Port",
              "state": "FL",
              "country": "US",
              "phone": ""
            },
            "shipping_address": {
              "firstname": "Jack",
              "lastname": "Russell",
              "address1": "5167 Butterfly Street",
              "address2": "",
              "zipcode": "34288",
              "city": "North Port",
              "state": "FL",
              "country": "US",
              "phone": ""
            }
          }
        ]
      }}'
    end
  end
end
