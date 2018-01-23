module Onix
  module Book
    class Subset
      # instanciate Subset form Nokogiri::XML::Element
      def self.parse(n)
        o = self.new
        o.parse(n)
        o
      end

      # parse Nokogiri::XML::Element
      def parse(n)
      end

      def unsupported(tag)
  #      raise SubsetUnsupported, tag.name
  #      puts "SubsetUnsupported: #{self.class}##{tag.name} (#{ShortToRef.names[tag.name]})"
      end

      def tag_match(v)
        Onix::Book::TagNameMatcher.new(v)
      end

      def self.tag_match(v)
        Onix::Book::TagNameMatcher.new(v)
      end

    end

  end
end