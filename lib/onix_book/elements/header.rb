module OnixBook
  module Elements
    class Header < Base
      element "Sender", :sub_element
      element "FromCompany", :text
      element "Addressee", :sub_element
      element "SentDate", :sub_element
      element "SentDateTime", :sub_element
      element "DefaultLanguageOfText", :text
      element "DefaultPriceTypeCode", :text
      element "DefaultCurrencyCode", :text

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
