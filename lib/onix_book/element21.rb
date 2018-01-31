module OnixBook
  class Element21
    # instanciate Subset form Nokogiri::XML::Element
    def initialize(node)
      self.parse(node)
    end

    # parse Nokogiri::XML::Element
    def parse(n)
    end

    def self.short_to_ref(name)
      loader = OnixBook::Data::Loader21.new
      loader.short_names(name)
    end

    def self.ref_to_short(name)
      loader = OnixBook::Data::Loader21.new
      loader.reference_names(name)
    end

    def self.get_class(name)
      if OnixBook::Elements::Base21.const_defined?(name, false)
        OnixBook::Elements::Base21.const_get(name)
      else
        OnixBook::Elements::Base.const_get(name)
      end
    end

    def unsupported(tag)
     # raise Element21Unsupported, tag.name
     puts "Element21Unsupported: #{self.class}##{tag.name}"
    end
  end
end
