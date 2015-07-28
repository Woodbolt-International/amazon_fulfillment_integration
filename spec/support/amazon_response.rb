module AmazoneResponse
  class << self
    def list_inventory_supply
      <<-EOF
      <?xml version="1.0"?>
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
      </ListInventorySupplyResponse>
      EOF
    end
  end
end
