module Onixo
  module Elements
    class SentDate < Base
      include Onixo::Helpers::ConvertDate
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
      include Onixo::Helpers::ConvertDate
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
      include Onixo::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "MarketDateRole", :sub_element

      scope :availability, lambda { human_code_match(:market_date_role, ["PublicationDate","EmbargoDate"])}

      def role
        @market_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class PriceDate < Base
      include Onixo::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "PriceDateRole", :sub_element

      scope :from, lambda { human_code_match(:price_date_role, "FromDate")}
      scope :until, lambda { human_code_match(:price_date_role, "UntilDate")}

      def role
        @price_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class SupplyDate < Base
      include Onixo::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "SupplyDateRole", :sub_element

      scope :availability, lambda { human_code_match(:supply_date_role, ["ExpectedAvailabilityDate","EmbargoDate"])}

      def role
        @supply_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class PublishingDate < Base
      include Onixo::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "PublishingDateRole", :yaml

      scope :publication, lambda { human_code_match(:publishing_date_role, ["PublicationDate","PublicationDateOfPrintCounterpart"])}
      scope :embargo, lambda { human_code_match(:publishing_date_role, "EmbargoDate")}
      scope :public_announcement, lambda { human_code_match(:publishing_date_role, "PublicAnnouncementDate")}

      def role
        @publishing_date_role
      end

      def parse(n)
        super
        parse_date(n)
      end
    end

    class ContentDate < Base
      include Onixo::Helpers::ConvertDate
      element "Date", :ignore
      element "DateFormat", :ignore
      element "ContentDateRole", :yaml

      scope :last_updated, lambda { human_code_match(:content_date_role, "LastUpdated")}

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
