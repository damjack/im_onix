module Onix
  module Book
    module Model
      module Identifiers
        class SenderIdentifier < Identifier
          element "SenderIDType", :subset
          def type
            @sender_id_type
          end
        end

        class AddresseeIdentifier < Identifier
          element "AddresseeIDType", :subset
          def type
            @addressee_id_type
          end
        end

        class AgentIdentifier < Identifier
          element "AgentIDType", :subset
          def type
            @agent_id_type
          end
        end

        class ImprintIdentifier < Identifier
          element "ImprintIDType", :subset
          def type
            @imprint_id_type
          end
        end

        class PublisherIdentifier < Identifier
          element "PublisherIDType", :subset
          def type
            @publisher_id_type
          end
        end

        class SupplierIdentifier < Identifier
          element "SupplierIDType", :subset
          def type
            @supplier_id_type
          end
        end

        class NameIdentifier < Identifier
          element "NameIDType", :subset
          def type
            @name_id_type
          end
        end

        class CollectionIdentifier < Identifier
          element "CollectionIDType", :subset
          def type
            @collection_id_type
          end
        end

        class ProductIdentifier < Identifier
          element "ProductIDType", :subset
          def type
            @product_id_type
          end
        end

        class SalesOutletIdentifier < Identifier
          element "SalesOutletIDType", :subset
          def type
            @sales_outlet_id_type
          end
        end

        class WorkIdentifier < Identifier
          element "WorkIDType", :subset
          def type
            @work_id_type
          end
        end
      end
    end
  end
end
