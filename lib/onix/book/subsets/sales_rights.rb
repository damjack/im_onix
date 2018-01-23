module Onix
  module Book
    module Subsets
      class SalesRights < SubsetDsl
        element "SalesRightsType", :subset
        element "Territory", :subset
        elements "SalesRestriction", :subset

        def type
          @sales_rights_type
        end
      end
    end
  end
end
