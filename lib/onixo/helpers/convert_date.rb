module Onixo
  module Helpers
    module ConvertDate
      attr_accessor :date_format, :date

      def parse_date(n)
        @date_format = Onixo::Tag.from_code("DateFormat", "00")
        date_txt = nil
        @date = nil
        n.elements.each do |t|
          case t
            when Onixo::Helpers::Matcher.new("DateFormat")
              @date_format = Onixo::Tag.parse("DateFormat", t)
            when Onixo::Helpers::Matcher.new("Date")
              date_txt = t.text
          end

          if t["dateformat"]
            @date_format = Onixo::Tag.from_code("DateFormat", t["dateformat"])
          end
        end

        code_format = format_from_code(@date_format.code)
        text_format = format_from_string(date_txt)
        format = code_format

        if code_format != text_format
          format = text_format
        end

        begin
          if format
            case @date_format.code
            when "00"
              @date = Date.strptime(date_txt, format)
            when "01"
              @date = Date.strptime(date_txt, format)
            when "05"
              @date = Date.strptime(date_txt, format)
            when "14"
              @date = Time.strptime(date_txt, format)
            else
              @date = nil
            end
          end
        rescue
          # invalid date
        end
      end

      def format_from_code(code)
        case code
          when "00"
            "%Y%m%d"
          when "01"
            "%Y%m"
          when "05"
            "%Y"
          when "14"
            "%Y%m%dT%H%M%S%z"
          else
            nil
        end
      end

      def format_from_string(str)
        case str
        when /^\d{4}\d{2}\d{2}T\d{2}\d{2}\d{2}/ || /^\d{4}\d{2}\d{2}T\d{2}\d{2}/
          "%Y%m%dT%H%M%S%z"
        when /^\d{4}\-\d{2}\-\d{2}$/
          "%Y-%m-%d"
        when /^\d{4}\d{2}\d{2}$/
          "%Y%m%d"
        when /^\d{4}\d{2}$/
          "%Y%m"
        when /^\d{4}$/
          "%Y"
        else
          nil
        end
      end

      def time
        @date.to_time
      end

      def self.strptime_date(str)
        Date.strptime(str, "%Y%m%d")
      end
    end
  end
end
