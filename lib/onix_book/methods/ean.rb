module OnixBook
  module Methods
    module Ean
      # EAN string identifier from identifiers
      def ean
        if ean_identifier
          ean_identifier.value
        else
          nil
        end
      end

      private
      def ean_identifier
        self.identifiers.select { |id| id.type.human == "Gtin13" }.first || self.identifiers.select { |id| id.type.human == "Isbn13" }.first
      end
    end
  end
end
