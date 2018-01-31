module OnixBook
  module Elements
    class SalesRestriction < Base
      element "SalesRestrictionType", :sub_element
      elements "SalesOutlet", :sub_element
      element "SalesRestrictionNote", :text

      attr_accessor :start_date, :end_date

      # shortcuts
      def type
        @sales_restriction_type
      end

      def note
        @sales_restriction_note
      end

      def initialize
        @sales_outlets=[]
      end

      def parse(n)
        super
        n.elements.each do |t|
          case t
            when OnixBook::Helpers::Matcher.new("StartDate")
              fmt = t["dateformat"] || "00"
              @start_date = OnixBook::Tools::Global.to_date(fmt, t.text)
            when OnixBook::Helpers::Matcher.new("EndDate")
              fmt = t["dateformat"] || "00"
              @end_date = OnixBook::Tools::Global.to_date(fmt, t.text)
          end
        end
      end
    end
  end
end
