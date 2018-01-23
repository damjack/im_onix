module Onix
  module Book
    module Subsets
      class Price < SubsetDsl
        elements "PriceDate", :subset
        element "CurrencyCode", :text
        element "Territory", :subset
        element "PriceType", :subset
        element "PriceQualifier", :subset
        element "PriceAmount", :float, {:lambda=>lambda{|v| (v*100).round}}
        element "PriceStatus", :subset
        element "Tax", :subset
        element "DiscountCoded", :subset

        # shortcuts
        def dates
          @price_dates
        end

        def amount
          @price_amount
        end

        def type
          @price_type
        end

        def currency
          @currency_code
        end

        def qualifier
          @price_qualifier
        end

        def discount
          @discount_coded
        end

        def from_date
          dt=@price_dates.select{|d| d.role.human=="FromDate"}.first
          if dt
            dt.date
          else
            nil
          end
        end

        def until_date
          dt=@price_dates.select { |d| d.role.human=="UntilDate" }.first
          if dt
            dt.date
          else
            nil
          end
        end

        def including_tax?
          if self.type.human=~/IncludingTax/
            true
          else
            false
          end
        end

      end
    end
  end
end
