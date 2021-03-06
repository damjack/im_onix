require 'yaml'

module Onixo
  module Data
    class Loader21
      ENCODING = "UTF-8"
      attr_accessor :tags
      attr_accessor :shorts
      attr_accessor :references

      def initialize
        @tags = YAML.load(File.read(File.join(File.dirname(__FILE__), "onix21", "tagnames.yml")))
        @shorts = YAML.load(File.read(File.join(File.dirname(__FILE__), "onix21", "shortnames.yml")))
        @references = @shorts.invert
      end

      def tag_names(name)
        @tags[name]
      end

      def short_names(name)
        @shorts[name]
      end

      def reference_names(name)
        @references[name]
      end

      def hash(number)
        @hash ||= load_codelist(number)
      end

      def load_codelist(number)
        list = YAML.load( File.read(File.join(File.dirname(__FILE__), "onix21", "codelists", "codelist_#{number.to_s}.yml"), nil, nil, encoding: ENCODING))
        list
      end
    end
  end
end
