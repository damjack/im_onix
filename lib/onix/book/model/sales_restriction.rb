module Onix
  module Book
    module Model
      class SalesRestriction < SubsetDsl
        element "SalesRestrictionType", :subset
        elements "SalesOutlet", :subset
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
              when tag_match("StartDate")
                fmt=t["dateformat"] || "00"
                @start_date = Onix::Book::Tools::Global.to_date(fmt, t.text)
              when tag_match("EndDate")
                fmt=t["dateformat"] || "00"
                @end_date = Onix::Book::Tools::Global.to_date(fmt, t.text)
            end
          end
        end
      end
    end
  end
end
