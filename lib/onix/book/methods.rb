module Onix
  module Book
    module EanMethods
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
        self.identifiers.select { |id| id.type.human=="Gtin13" }.first || self.identifiers.select { |id| id.type.human=="Isbn13" }.first
      end
    end

    module IsbnMethods
      # ISBN-13 string identifier from identifiers
      def isbn13
        if isbn13_identifier
          isbn13_identifier.value
        else
          nil
        end
      end

      private
      def isbn13_identifier
        self.identifiers.select{|id| id.type.human=="Isbn13"}.first
      end
    end

    module GlnMethods
      # GLN string identifier from identifiers
      def gln
        if gln_identifier
          if gln_identifier.value =~ /\d{13}/
            gln_identifier.value
          else
            puts "Invalid GLN #{gln_identifier.value}"
            nil
          end
        else
          nil
        end
      end

      # private
      def gln_identifier
        self.identifiers.select { |id| id.type.human=="Gln" }.first
      end
    end

    module ProprietaryIdMethods
      def proprietary_ids
        self.identifiers.select { |id| id.type.human=="Proprietary" }
      end
    end
  end
end