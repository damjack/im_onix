module Onixo
  module Elements
    class Addressee < Base
      include Onixo::Methods::Gln
      elements "AddresseeIdentifier", :sub_element
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
