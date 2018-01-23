module Onix
  module Book
    module Model
      class RelatedWork < SubsetDsl
        include EanMethods
        element "WorkRelationCode", :subset
        elements "WorkIdentifier", :subset

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
end