# -*- encoding : utf-8 -*-
require 'yaml'

module OnixBook
  class Tag21
    # code as defined in ONIX documentation codelist
    attr_accessor :code
    # humanized string (eg: "Digital watermarking" become DigitalWatermarking,
    # "PDF" become Pdf, "BISAC Subject Heading" become BisacSubjectHeading, etc)
    attr_accessor :human
    attr_accessor :hash
    attr_accessor :list

    def initialize(name, node)
      loader = OnixBook::Data::Loader21.new
      tag_id = loader.tag_names(name)
      @hash = loader.hash(tag_id)
      @list = @hash.to_a.map{|h| h.first}

      self.parse(node)
    end

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

    def parse(n)
      @code = n.text
      @human = @hash[n.text]
    end

    # create Code from string ONIX code
    def self.from_code(code)
      o = self.new
      o.code = code
      o.human = @hash[code]
      o
    end

    # create Code from humanized string code
    def self.from_human(human)
      o = self.new
      o.human = human
      o.code = @hash.key(human)
      o
    end

    # Humanized string code
    def human
      @human
    end

    # ONIX code
    def onix
      @code
    end

    def unsupported(tag)
     raise TagUnsupported, tag.name
    end
  end
end
