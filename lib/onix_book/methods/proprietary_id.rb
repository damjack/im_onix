module OnixBook
  module Methods
    module ProprietaryId
      def proprietary_ids
        self.identifiers.select { |id| id.type.human == "Proprietary" }
      end
    end
  end
end
