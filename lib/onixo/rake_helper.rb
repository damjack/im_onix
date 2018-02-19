module Onixo
  module RakeHelper
    class << self
      def split(file: nil, row: 500, output: "out/")
        origin_cnt = 0
        parts = []
        parts_cnt = 0
        output = "#{output}#{file.split('/').last}"
        Onixo::Helpers::Converter.each_xml_product(file) do |prod|
          tmp_parser = Onixo::Parser.new()
          output = tmp_parser.analyze(prod)

          parts[parts_cnt] ||= ""
          parts[parts_cnt] += prod + "\n"

          if output[:products].first.sold_separately?
            parts_cnt += 1
          end

          if parts_cnt > row - 1
            write_part(origin_cnt, parts, output)
            parts = []
            parts_cnt = 0
            origin_cnt += 1
          end
        end

        if parts_cnt > 0
          write_part(origin_cnt, parts, output)
          parts = []
          parts_cnt = 0
        end

        true
      end

      def write_part(origin_cnt, parts, output)
        out_filename = output + "-" + origin_cnt.to_s + ".onix"
        fw = File.open(out_filename, 'w')
        fw.write("<ONIXMessage release=\"3.0\" xmlns=\"http://ns.editeur.org/onix/3.0/reference\">\n")
        parts.each do |p|
          fw.write p
        end
        fw.write("</ONIXMessage>\n")
        fw.close
      end
    end
  end
end
