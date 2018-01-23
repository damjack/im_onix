require 'onix/book/subset/identifiers/identifier'

module Onix
  module Book
    module Subsets
      class Identifier < SubsetDsl
        element "IDValue", :text
        element "IDTypeName", :text

        def value
          @id_value
        end

        def name
          @id_type_name
        end

        def type
          nil
        end

        def uniq_id
          "#{type.code}-#{value}"
        end
      end
    end
  end
end