module OnixBook
  class Element
    # instanciate Subset form Nokogiri::XML::Element
    def initialize(node)
      self.parse(node)
    end

    # parse Nokogiri::XML::Element
    def parse(n)
    end

    def self.short_to_ref(name)
      loader = OnixBook::Data::Loader.new
      loader.short_names(name)
    end

    def self.ref_to_short(name)
      loader = OnixBook::Data::Loader.new
      loader.reference_names(name)
    end

    def self.get_class(name)
      OnixBook::Elements.const_get(name)
    end

    def unsupported(tag)
     # raise ElementUnsupported, tag.name
     puts "ElementUnsupported: #{self.class}##{tag.name}"
    end
  end
end
