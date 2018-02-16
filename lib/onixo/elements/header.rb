module Onixo
  module Elements
    class Header < Base
      element "Sender", :sub_element
      element "FromCompany", :text
      element "Addressee", :sub_element
      element "SentDate", :sub_element
      element "SentDateTime", :text
      element "DefaultLanguageOfText", :text
      element "DefaultPriceTypeCode", :text
      element "DefaultCurrencyCode", :text

      # shortcuts
      def identifiers
        @sender.identifiers
      end

      def name
        @sender.name
      end
    end
  end
end
