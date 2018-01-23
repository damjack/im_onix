# -*- encoding : utf-8 -*-
require 'yaml'

module Onix
  module Book
    module Model
      class CodeFromYamlWithMime < CodeFromYaml
        # main formats
        def mimetype
          case self.human
            when "Epub"
              "application/epub"
            when "Pdf"
              "application/pdf"
            when "Mobipocket"
              "application/x-mobipocket-ebook"
            when "Gif"
              "image/gif"
            when "Jpeg"
              "image/jpeg"
            when "Png"
              "image/png"
          end
        end
      end
    end
  end
end