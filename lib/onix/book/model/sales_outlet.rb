module Onix
  module Book
    module Model
      class SalesOutlet < SubsetDsl
        element "SalesOutletIdentifier", :subset
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
end
