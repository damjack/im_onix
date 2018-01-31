module OnixBook
  module Elements
    class Tax < Base
      element "TaxAmount", :float, {:lambda => lambda {|v| (v*100).round }}
      element "TaxableAmount", :float, {:lambda => lambda {|v| (v*100).round }}
      element "TaxRatePercent", :float
      element "TaxRateCode", :sub_element
      element "TaxType", :sub_element

      # shortcuts
      def rate_code
        @tax_rate_code
      end

      def amount
        @tax_amount
      end

      def rate_percent
        @tax_rate_percent
      end
    end
  end
end
