module OnixBook
  module Elements
    class Sender < Base
      include OnixBook::Methods::Gln

      elements "SenderIdentifier", :sub_element
      element "SenderName", :text
      element "ContactName", :text
      element "EmailAddress", :text

      # shortcuts
      def identifiers
        @sender_identifiers
      end

      def name
        @sender_name
      end
    end
  end
end
