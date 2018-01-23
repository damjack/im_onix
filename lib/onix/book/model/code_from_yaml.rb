# -*- encoding : utf-8 -*-
require 'yaml'

module Onix
  module Book
    module Model
      class CodeFromYaml < Code
        ENCODING = "UTF-8"

        include Onix::Book::Tools::Path

        def code_list_filename(number)
          File.join(code_lists_path, "list_#{number.to_s.rjust(3,'0')}.yml")
        end

        def self.hash
          @hash ||= YAML.load( File.read(code_list_filename(self.code_ident), nil, nil, encoding: ENCODING ) )[:codelist]
        end

        def self.list
          self.hash.to_a.map{|h| h.first}
        end

        def self.code_ident
          nil
        end
      end
    end
  end
end