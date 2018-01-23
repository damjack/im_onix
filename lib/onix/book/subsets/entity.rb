module Onix
  module Book
    module Subsets
      class Entity < SubsetDsl
        # entity name
        attr_accessor :name
        # entity role
        attr_accessor :role
        # entity Identifier list
        attr_accessor :identifiers

        include GlnMethods

        def initialize
          super
          @identifiers = []
        end

        def self.role_tag
          "#{self.prefix}Role"
        end

        def self.name_tag
          "#{self.prefix}Name"
        end

        def self.identifier_tag
          "#{self.prefix}Identifier"
        end

        def parse(n)
          super
          n.children.each do |t|
            case t
              when tag_match(self.class.name_tag)
                @name=t.text
              when tag_match(self.class.role_tag)
                if self.class.role_class
                  @role=self.class.role_class.parse(t)
                end
              when tag_match(self.class.identifier_tag)
                if self.class.identifier_class
                  @identifiers << self.class.identifier_class.parse(t)
                end
            end
          end
        end

        private
        def self.prefix
        end

        def self.identifier_class
          nil
        end

        def self.role_class
          nil
        end
      end
    end
  end
end

require 'onix/book/subset_dsl/entities/entity'