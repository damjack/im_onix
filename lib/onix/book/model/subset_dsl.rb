require 'onix/book/short_to_ref'
require 'onix/book/ref_to_short'
require 'onix/book/model/element_parser'

module Onix
  module Book
    module Model
      class SubsetDsl < Subset
        def self.element(name, type, options={})
          @elements ||= {}
          @elements[name] = Onix::Book::Model::ElementParser.new(name, type, options)
          short_name=self.ref_to_short(name)
          if short_name
            @elements[short_name]=@elements[name]
          end
          attr_accessor @elements[name].to_sym
        end

        # shortcut for element :array=>true
        def self.elements(name, type, options={})
          self.element(name, type, options.merge(:array => true))
        end

        def self._ancestors_registered_elements
          els=self.registered_elements
          sup=self
          while sup.respond_to?(:registered_elements)
            els.merge!(sup.registered_elements) if sup.registered_elements
            sup=sup.superclass
          end
          els
        end

        def self.ancestors_registered_elements
          @ancestors_registered_elements||=_ancestors_registered_elements
        end

        def self.registered_elements
          @elements||{}
        end

        def initialize
          # initialize plural as Array
          self.class.ancestors_registered_elements.each do |k, e|
            if e.is_array?
              instance_variable_set(e.to_instance, [])
            end
          end
        end

        def self.short_to_ref(name)
          Onix::Book::ShortToRef.names[name]
        end

        def self.ref_to_short(name)
          Onix::Book::RefToShort.names[name]
        end

        def self.get_class(name)
          Onix::Book.const_get(name)
        end

        def parse(n)
          n.elements.each do |t|
            name = t.name
            e=self.class.ancestors_registered_elements[name]
            if e
              case e.type
                when :subset
                  val=self.class.get_class(e.class_name).parse(t)
                when :text
                  val=t.text
                when :integer
                  val=t.text.to_i
                when :float
                  val=t.text.to_f
                when :bool
                  val=true
                when :ignore
                  val=nil
                else
                  val=t.text
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

        def unsupported(tag)
    #      raise SubsetUnsupported, tag.name
    #      puts "SubsetUnsupported: #{self.class}##{tag.name} (#{self.class.short_to_ref(tag.name)})"
        end

      end
    end
  end
end