module OnixBook
  module Elements
    class SalesOutlet < Base
      element "SalesOutletIdentifier", :sub_element
      element "SalesOutletName", :text

      def identifier
        @sales_outlet_identifier
      end

      def name
        @sales_outlet_name
      end
    end
  end
end
