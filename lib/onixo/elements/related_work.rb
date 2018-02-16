module Onixo
  module Elements
    class RelatedWork < Base
      # include Onixo::EanMethods
      element "WorkRelationCode", :sub_element
      elements "WorkIdentifier", :sub_element

      def code
        @work_relation_code
      end

      def identifiers
        @work_identifiers
      end

      # full Product if referenced in ONIXMessage
      def product
        @product
      end

      def product=v
        @product=v
      end
    end
  end
end
