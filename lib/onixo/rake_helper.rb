module Onixo
  module RakeHelper
    class << self
      def truncate_to_multiple(file: nil, row: 500, output: "out/", release: "3.0")
        origin_cnt = 0
        parts = []
        parts_cnt = 0
        output = "#{output}#{file.split('/').last}"
        header_xml = Onixo::Helpers::Converter.xml_header(file)
        Onixo::Helpers::Converter.each_xml_product(file) do |prod|
          tmp_parser = Onixo::Parser.new()
          analyzed = tmp_parser.analyze(prod)

          parts[parts_cnt] ||= ""
          parts[parts_cnt] += prod + "\n"

          if analyzed[:products].first.sold_separately?
            parts_cnt += 1
          end

          if parts_cnt > row - 1
            write_part(origin_cnt, header_xml, parts, output, release)
            parts = []
            parts_cnt = 0
            origin_cnt += 1
          end
        end

        if parts_cnt > 0
          write_part(origin_cnt, header_xml, parts, output, release)
          parts = []
          parts_cnt = 0
        end

        true
      end

      def write_part(origin_cnt, header_xml, parts, output, release)
        out_filename = output + "-" + origin_cnt.to_s + ".onix"
        fw = File.open(out_filename, 'w')
        fw.write("<ONIXMessage release=\"#{release}\" xmlns=\"http://ns.editeur.org/onix/3.0/reference\">\n")
        fw.write(header_xml)
        parts.each do |p|
          fw.write p
        end
        fw.write("</ONIXMessage>\n")
        fw.close
      end
    end
  end
end
