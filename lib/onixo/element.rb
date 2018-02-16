module Onixo
  class Element
    # instanciate Subset form Nokogiri::XML::Element
    def analyze(node)
      self.parse(node)
      self
    end

    # parse Nokogiri::XML::Element
    def parse(n)
    end

    def self.short_to_ref(name)
      loader = Onixo::Data::Loader.new
      loader.short_names(name)
    end

    def self.ref_to_short(name)
      loader = Onixo::Data::Loader.new
      loader.reference_names(name)
    end

    def self.get_class(name)
      Onixo::Elements.const_get(name)
    end

    def unsupported(tag)
     # raise ElementUnsupported, tag.name
     #puts "ElementUnsupported: #{self.class}##{tag.name}"
    end
  end
end
