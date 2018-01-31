module OnixBook
  module Elements
    class Base < OnixBook::Element
      def self.element(name, type, options={})
        @elements ||= {}
        @elements[name] = OnixBook::Helpers::ElementParser.new(name, type, options)
        short_name = OnixBook::Element.ref_to_short(name)
        if short_name
          @elements[short_name] = @elements[name]
        end
        attr_accessor @elements[name].to_sym
      end

      # shortcut for element :array=>true
      def self.elements(name, type, options={})
        self.element(name, type, options.merge(:array => true))
      end

      def self._ancestors_registered_elements
        els = self.registered_elements
        sup = self
        while sup.respond_to?(:registered_elements)
          els.merge!(sup.registered_elements) if sup.registered_elements
          sup = sup.superclass
        end
        els
      end

      def self.ancestors_registered_elements
        @ancestors_registered_elements ||= _ancestors_registered_elements
      end

      def self.registered_elements
        @elements || {}
      end

      def initialize
        # initialize plural as Array
        self.class.ancestors_registered_elements.each do |k, e|
          if e.is_array?
            instance_variable_set(e.to_instance, [])
          end
        end
      end

      def parse(n)
        n.elements.each do |t|
          name = t.name
          e = self.class.ancestors_registered_elements[name]
          if e
            case e.type
              when :sub_element
                val = self.class.get_class(e.class_name).parse(t)
              when :yaml
                val = OnixBook::Tag.new(e.class_name, t)
              when :yaml_21
                val = OnixBook::Tag21.new(e.class_name, t)
              when :text
                val = t.text
              when :integer
                val = t.text.to_i
              when :float
                val = t.text.to_f
              when :bool
                val = true
              when :ignore
                val = nil
              else
                val = t.text
            end

            if val
              if e.is_array?
                instance_variable_get(e.to_instance).send(:push, val)
              else
                instance_variable_set(e.to_instance, e.lambda(val))
              end
            end
          else
            unsupported(t)
          end
        end
      end

    end
  end
end

require 'onix_book/elements/addressee'
require 'onix_book/elements/collateral_detail'
require 'onix_book/elements/contributor'
require 'onix_book/elements/date'
require 'onix_book/elements/descriptive_detail'
require 'onix_book/elements/discount_coded'
require 'onix_book/elements/entity'
require 'onix_book/elements/identifier'
require 'onix_book/elements/price'
require 'onix_book/elements/product_supply'
require 'onix_book/elements/product'
require 'onix_book/elements/publishing_detail'
require 'onix_book/elements/related_material'
require 'onix_book/elements/related_product'
require 'onix_book/elements/related_work'
require 'onix_book/elements/sales_outlet'
require 'onix_book/elements/sales_restriction'
require 'onix_book/elements/sales_rights'
require 'onix_book/elements/sender'
require 'onix_book/elements/subject'
require 'onix_book/elements/supporting_resource'
require 'onix_book/elements/tax'
require 'onix_book/elements/territory'
require 'onix_book/elements/website'
