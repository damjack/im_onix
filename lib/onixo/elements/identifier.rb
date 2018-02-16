module Onixo
  module Elements
    class Identifier < Base
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

    class SenderIdentifier < Identifier
      element "SenderIDType", :yaml
      def type
        @sender_id_type
      end
    end

    class AddresseeIdentifier < Identifier
      element "AddresseeIDType", :yaml
      def type
        @addressee_id_type
      end
    end

    class AgentIdentifier < Identifier
      element "AgentIDType", :sub_element
      def type
        @agent_id_type
      end
    end

    class ImprintIdentifier < Identifier
      element "ImprintIDType", :yaml
      def type
        @imprint_id_type
      end
    end

    class PublisherIdentifier < Identifier
      element "PublisherIDType", :yaml
      def type
        @publisher_id_type
      end
    end

    class SupplierIdentifier < Identifier
      element "SupplierIDType", :yaml
      def type
        @supplier_id_type
      end
    end

    class NameIdentifier < Identifier
      element "NameIDType", :yaml
      def type
        @name_id_type
      end
    end

    class CollectionIdentifier < Identifier
      element "CollectionIDType", :yaml
      def type
        @collection_id_type
      end
    end

    class ProductIdentifier < Identifier
      element "ProductIDType", :yaml
      def type
        @product_id_type
      end
    end

    class SalesOutletIdentifier < Identifier
      element "SalesOutletIDType", :sub_element
      def type
        @sales_outlet_id_type
      end
    end

    class WorkIdentifier < Identifier
      element "WorkIDType", :yaml
      def type
        @work_id_type
      end
    end
  end
end
