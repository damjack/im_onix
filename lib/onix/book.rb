require 'onix/book/tools/path'
require 'onix/book/tools/global'
require 'onix/book/tools/date'

require 'onix/book/version'
require 'onix/book/error'
require 'onix/book/methods'
require 'onix/book/onix21'
require 'onix/book/parser'
require 'onix/book/product_supplies_extractor'
require 'onix/book/subset'
require 'onix/book/subset/code'
require 'onix/book/subset/code/code_from_yaml'
require 'onix/book/subset/code/code_from_yaml/codes'
require 'onix/book/subset_dsl'

require 'nokogiri'
require 'yaml'

module Onix
  module Book
    @@data_path = nil
  
    def self.data_path=(data_path)
      @@data_path = data_path 
    end

    def self.data_path
      @@data_path || File.join(File.dirname(__FILE__), "data", "onix30")
    end

    class ShortToRef
      def self.names
        @shortnames ||= YAML.load(File.read(File.dirname(__FILE__), "data", "onix30", "shortnames.yml"))
      end
    end

    class RefToShort
      def self.names
        @refnames||=ShortToRef.names.invert
      end
    end

    TagNameMatcher = Struct.new(:tag_name) do
      def ===(target)
        if target.element?
          name=target.name
          name.casecmp(tag_name) == 0 or ShortToRef.names[name] == tag_name
        else
          false
        end
      end
    end
  end
end