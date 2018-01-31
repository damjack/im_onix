module OnixBook
  module Elements
    class SentDate < Base
      include OnixBook::Helpers::ConvertDate
      element "SentDate", :text

      def sent_date
        @sent_date
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class SentDateTime < Base
      include OnixBook::Helpers::ConvertDate
      element "SentDateTime", :text

      def sent_date_time
        @sent_date_time
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class MarketDate < Base
      include OnixBook::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "MarketDateRole", :sub_element

      def role
        @market_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class PriceDate < Base
      include OnixBook::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "PriceDateRole", :sub_element

      def role
        @price_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class SupplyDate < Base
      include OnixBook::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "SupplyDateRole", :sub_element

      def role
        @supply_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class PublishingDate < Base
      include OnixBook::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "PublishingDateRole", :sub_element

      def role
        @publishing_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class ContentDate < Base
      include OnixBook::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "ContentDateRole", :sub_element

      def role
        @content_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end
  end
end
