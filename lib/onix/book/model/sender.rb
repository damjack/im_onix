module Onix
  module Book
    module Model
      class Sender < SubsetDsl
        include GlnMethods

        elements "SenderIdentifier", :subset
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
end