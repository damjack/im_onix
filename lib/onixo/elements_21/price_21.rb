module Onixo
  module Elements21
    class Price < Base21
      element "PriceTypeCode", :yaml_21, :klass => "PriceType"
      element "PriceAmount", :float, {:lambda => lambda { |v| (v*100).round }}
      element "PriceQualifier", :sub_element
      element "DiscountCoded", :sub_element
      element "CurrencyCode", :text
      elements "CountryCode", :text
      element "PriceStatus", :yaml_21
      element "PriceEffectiveFrom", :text
      element "PriceEffectiveUntil", :text

      def amount
        @price_amount
      end

      def currency
        @currency_code
      end

      def qualifier
        @price_qualifier
      end

      def including_tax?
        if @price_type_code.human =~/IncludingTax/
          true
        else
          false
        end
      end

      def from_date
        if @price_effective_from
          Date.strptime(@price_effective_from, "%Y%m%d")
        end
      end

      def until_date
        if @price_effective_until
          Date.strptime(@price_effective_until, "%Y%m%d")
        end
      end

      def territory
        Territory.new(@country_codes)
      end

      def tax
        nil
      end
    end
  end
end
