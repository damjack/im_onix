module OnixBook
  module Methods
    module Gln
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
        self.identifiers.select { |id| id.type.human == "Gln" }.first
      end
    end
  end
end
