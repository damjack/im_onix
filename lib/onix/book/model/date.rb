module Onix
  module Book
    module Model
      class MarketDate < SubsetDsl
        include Helper::Date
        element "Date", :ignore
        element "DateFormat", :ignore
        element "MarketDateRole", :subset

        def role
          @market_date_role
        end

        def parse(n)
          super
          Onix::Book::Tools::Date.parse_date(n)
        end
      end

      class PriceDate < SubsetDsl
        include Helper::Date
        element "Date", :ignore
        element "DateFormat", :ignore
        element "PriceDateRole", :subset

        def role
          @price_date_role
        end

        def parse(n)
          super
          Onix::Book::Tools::Date.parse_date(n)
        end
      end

      class SupplyDate < SubsetDsl
        include Helper::Date
        element "Date", :ignore
        element "DateFormat", :ignore
        element "SupplyDateRole", :subset

        def role
          @supply_date_role
        end

        def parse(n)
          super
          Onix::Book::Tools::Date.parse_date(n)
        end
      end

      class PublishingDate < SubsetDsl
        include Helper::Date
        element "Date", :ignore
        element "DateFormat", :ignore
        element "PublishingDateRole", :subset

        def role
          @publishing_date_role
        end

        def parse(n)
          super
          Onix::Book::Tools::Date.parse_date(n)
        end
      end

      class ContentDate < SubsetDsl
        include Helper::Date
        element "Date", :ignore
        element "DateFormat", :ignore
        element "ContentDateRole", :subset

        def role
          @content_date_role
        end

        def parse(n)
          super
          Onix::Book::Tools::Date.parse_date(n)
        end
      end
    end
  end
end