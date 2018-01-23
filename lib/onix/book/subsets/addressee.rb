module Onix
  module Book
    module Subsets
      class Addressee < SubsetDsl
        include GlnMethods

        elements "AddresseeIdentifier", :subset
        element "AddresseeName", :text

        # shortcuts
        def identifiers
          @addressee_identifiers
        end

        def name
          @addressee_name
        end
      end
    end
  end
end