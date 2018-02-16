module Onixo
  module Elements
    class SalesRights < Base
      element "SalesRightsType", :yaml
      element "Territory", :sub_element
      elements "SalesRestriction", :sub_element

      def type
        @sales_rights_type
      end
    end
  end
end
