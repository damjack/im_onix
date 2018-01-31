module OnixBook
  module Elements
    class Market < Base
      element "Territory", :sub_element
    end

    class MarketPublishingDetail < Base
      elements "MarketDate", :sub_element
      element "MarketPublishingStatus", :sub_element
      elements "PublisherRepresentative", :sub_element, {:klass=>"Agent"}

      def availability_date
        av=@market_dates.select{|sd| sd.role.human=="PublicationDate" || sd.role.human=="EmbargoDate"}.first
        if av
          av.date
        else
          nil
        end
      end
    end

    class SupplyDetail < Base
      element "ProductAvailability", :sub_element
      elements "Supplier", :sub_element
      elements "SupplyDate", :sub_element
      elements "Price", :sub_element
      element "UnpricedItemType", :sub_element

      def availability
        @product_availability
      end

      def distributors
        @suppliers.select{|s| s.role.human=~/Distributor/}.uniq
      end

      def available?
        ["Available","NotYetAvailable","InStock","ToOrder","Pod"].include?(@product_availability.human)
      end

      def sold_separately?
        @product_availability.human!="NotSoldSeparately"
      end

      def availability_date
        av=@supply_dates.select{|sd| sd.role.human=="ExpectedAvailabilityDate" || sd.role.human=="EmbargoDate"}.first
        if av
          av.date
        else
          nil
        end
      end
    end

    class ProductSupply < Base
      elements "SupplyDetail", :sub_element
      elements "Market", :sub_element
      element "MarketPublishingDetail", :sub_element

      def availability_date
        if @market_publishing_detail
          @market_publishing_detail.availability_date
        end
      end

      def countries
        @markets.map{|m| m.territory.countries}.flatten.uniq
      end

      def distributors
        @supply_details.map{|sd| sd.distributors}.flatten.uniq{|d| d.name}
      end

      def available_supply_details
        @supply_details.select{|sd| sd.available?}
      end

      def unavailable_supply_details
        @supply_details.delete_if{|sd| sd.available?}
      end

      def available?
        self.available_supply_details.length > 0
      end
    end
  end
end
