module Onix
  module Book
    module Model
      class Market < SubsetDsl
        element "Territory", :subset
      end

      class MarketPublishingDetail < SubsetDsl
        elements "MarketDate", :subset
        element "MarketPublishingStatus", :subset
        elements "PublisherRepresentative", :subset, {:klass=>"Agent"}

        def availability_date
          av=@market_dates.select{|sd| sd.role.human=="PublicationDate" || sd.role.human=="EmbargoDate"}.first
          if av
            av.date
          else
            nil
          end
        end
      end

      class SupplyDetail < SubsetDsl
        element "ProductAvailability", :subset
        elements "Supplier", :subset
        elements "SupplyDate", :subset
        elements "Price", :subset
        element "UnpricedItemType", :subset

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

      class ProductSupply < SubsetDsl
        elements "SupplyDetail", :subset
        elements "Market", :subset
        element "MarketPublishingDetail", :subset

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
end
