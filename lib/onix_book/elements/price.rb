module OnixBook
  module Elements
    class Price < Base
      elements "PriceDate", :sub_element
      element "CurrencyCode", :text
      element "Territory", :sub_element
      element "PriceType", :yaml
      element "PriceQualifier", :sub_element
      element "PriceAmount", :float, {:lambda => lambda {|v| (v*100).round }}
      element "PriceStatus", :yaml
      element "Tax", :sub_element
      element "DiscountCoded", :sub_element

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
