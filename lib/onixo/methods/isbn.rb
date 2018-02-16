module Onixo
  module Methods
    module Isbn
      # ISBN-13 string identifier from identifiers
      def isbn13
        if isbn13_identifier
          isbn13_identifier.value
        else
          nil
        end
      end

      # ISBN-10 string identifier from identifiers
      def isbn10
        if isbn10_identifier
          isbn10_identifier.value
        else
          nil
        end
      end

      private
      def isbn13_identifier
        self.identifiers.select{|id| id.type.human == "Isbn13" }.first
      end

      def isbn10_identifier
        self.identifiers.select{|id| id.type.human == "Isbn10" }.first
      end
    end
  end
end
