require 'onix/book/tools/path'
require 'onix/book/tools/global'
require 'onix/book/tools/date'

require 'onix/book/version'
require 'onix/book/error'

require 'onix/book/methods'
require 'onix/book/onix21'
require 'onix/book/parser'
require 'onix/book/product_supplies_extractor'

require 'onix/book/short_to_ref'
require 'onix/book/ref_to_short'
require 'onix/book/model/element_parser'
require 'onix/book/model/subset'
require 'onix/book/model/subset_dsl'
require 'onix/book/model/code'
require 'onix/book/model/code_from_yaml'
require 'onix/book/model/code_from_yaml_with_mime'
require 'onix/book/model/code_indents'

require 'nokogiri'
require 'yaml'

module Onix
  module Book
    @@data_path = nil
  
    def self.data_path=(data_path)
      @@data_path = data_path 
    end

    def self.data_path
      @@data_path || File.join(File.dirname(__FILE__), "data")
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