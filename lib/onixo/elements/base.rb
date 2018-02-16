module Onixo
  module Elements
    class Base < Onixo::Element
      def self.element(name, type, options={})
        @elements ||= {}
        @elements[name] = Onixo::Helpers::ElementParser.new(name, type, options)
        short_name = Onixo::Element.ref_to_short(name)
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

        self
      end

      def parse(n)
        n.elements.each do |t|
          name = t.name
          e = self.class.ancestors_registered_elements[name]
          if e
            case e.type
              when :sub_element
                val = self.class.get_class(e.class_name).new().analyze(t)
              when :yaml
                val = Onixo::Tag.new(e.class_name.to_s, t)
              when :yaml_21
                val = Onixo::Tag21.new(e.class_name.to_s, t)
              when :text
                val = t.text.strip
              when :integer
                val = t.text.to_i
              when :float
                val = t.text.to_f
              when :bool
                val = true
              when :ignore
                val = nil
              else
                val = t.text.strip
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

require 'onixo/elements/addressee'
require 'onixo/elements/collateral_detail'
require 'onixo/elements/contributor'
require 'onixo/elements/date'
require 'onixo/elements/descriptive_detail'
require 'onixo/elements/discount_coded'
require 'onixo/elements/entity'
require 'onixo/elements/header'
require 'onixo/elements/identifier'
require 'onixo/elements/price'
require 'onixo/elements/product_supply'
require 'onixo/elements/product'
require 'onixo/elements/publishing_detail'
require 'onixo/elements/related_material'
require 'onixo/elements/related_product'
require 'onixo/elements/related_work'
require 'onixo/elements/sales_outlet'
require 'onixo/elements/sales_restriction'
require 'onixo/elements/sales_rights'
require 'onixo/elements/sender'
require 'onixo/elements/subject'
require 'onixo/elements/supporting_resource'
require 'onixo/elements/tax'
require 'onixo/elements/territory'
require 'onixo/elements/website'
