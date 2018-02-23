module Onixo
  module Helpers
    module Converter
      # convert arbitrary arg to File/String
      def file_to_data(arg)
        data = ""
        case arg
          when String
            if File.file?(arg)
              data = File.read(arg)
            else
              data = arg
            end
          when File, Tempfile
            data = arg.read
          else
            raise ArgumentError, "Unable to read from file or IO stream"
        end
        data
      end

      def self.xml_header(arg)
        data = File.read(arg)
        output = ""
        Nokogiri::XML::Reader(data).each do |node|
          if node.name == 'Header' and node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
            output = node.outer_xml
          end
        end

        output
      end

      # traverse each product as xml string
      def self.each_xml_product(arg,  &block)
        data = File.read(arg)
        Nokogiri::XML::Reader(data).each do |node|
          if node.name == 'Product' and node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
            yield(node.outer_xml)
          end
        end
      end

      # traverse each product as xml string with added ONIXMessage
      def self.each_xml_product_as_full_message(arg, &block)
        each_xml_product(arg) do |p|
          yield("<ONIXMessage>\n"+p+"\n</ONIXMessage>\n")
        end
      end

      def text_at(n, xpath)
        if n.at_xpath(xpath)
          n.at_xpath(xpath).text.strip
        else
          nil
        end
      end

      def mandatory_text_at(n, xpath)
        text_at(n, xpath)
      end

      def strip_html(html)
        html.gsub(/&nbsp;/," ").gsub(/<[^>]*(>+|\s*\z)/m, '')
      end

      def to_date(date_format, date_str_f)
        case date_format
          when "00"
            Date.strptime(date_str_f, "%Y%m%d")
          when "01"
            Date.strptime(date_str_f, "%Y%m")
          when "05"
            Time.strptime(date_str_f, "%Y")
          when "13"
            Date.strptime(date_str_f, "%Y%m%dT%H%M")
          when "14"
            Time.strptime(date_str_f, "%Y%m%dT%H%M%S")
          else
            nil
        end
      end
    end
  end
end
