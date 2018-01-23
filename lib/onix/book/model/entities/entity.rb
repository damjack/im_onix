module Onix
  module Book
    module Model
      module Entities
        class Agent < Entity
          private
          def self.prefix
            "Agent"
          end

          def self.identifier_class
            AgentIdentifier
          end

          def self.role_class
            AgentRole
          end
        end

        class Imprint < Entity
          private
          def self.prefix
            "Imprint"
          end

          def self.identifier_class
            ImprintIdentifier
          end

          def self.role_class
            nil
          end
        end

        class Supplier < Entity
          elements "Website", :subset

          private
          def self.prefix
            "Supplier"
          end

          def self.identifier_class
            SupplierIdentifier
          end

          def self.role_class
            SupplierRole
          end
        end

        class Publisher < Entity
          elements "Website", :subset

          def initialize
            super
            @websites = []
          end

          private
          def self.prefix
            "Publisher"
          end

          def self.role_tag
            "PublishingRole"
          end

          def self.identifier_class
            PublisherIdentifier
          end

          def self.role_class
            PublishingRole
          end
        end
      end
    end
  end
end