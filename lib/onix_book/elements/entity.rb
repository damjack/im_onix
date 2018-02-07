module OnixBook
  module Elements
    class Entity < Base
      # entity name
      attr_accessor :name
      # entity role
      attr_accessor :role
      # entity Identifier list
      attr_accessor :identifiers

      # include OnixBook::GlnMethods

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
            when OnixBook::Helpers::Matcher.new(self.class.name_tag)
              @name=t.text
            when OnixBook::Helpers::Matcher.new(self.class.role_tag)
              if self.class.role_class
                @role=self.class.role_class.new().parse(t)
              end
            when OnixBook::Helpers::Matcher.new(self.class.identifier_tag)
              if self.class.identifier_class
                @identifiers << self.class.identifier_class.new().parse(t)
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
      elements "Website", :sub_element
      elements "SupplierRole", :yaml

      private
      def self.prefix
        "Supplier"
      end

      def self.identifier_class
        SupplierIdentifier
      end

      # def self.role_class
      #   SupplierRole
      # end
    end

    class Publisher < Entity
      elements "Website", :sub_element
      elements "PublishingRole", :yaml

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

      # def self.role_class
      #   PublishingRole
      # end
    end
  end
end
