module OnixBook
  module Elements
    class PublishingDetail < Base
      element "PublishingStatus", :sub_element
      elements "SalesRights", :sub_element, {:pluralize=>false}
      element "SalesRestriction", :sub_element
      element "ROWSalesRightsType", :sub_element, {:klass=>"SalesRightsType"}
      elements "PublishingDate", :sub_element
      elements "Publisher", :sub_element
      element "CityOfPublication", :text
      element "CountryOfPublication", :text
      elements "Imprint", :sub_element

      def publisher
        main_publishers = @publishers.select { |p| p.role.human=="Publisher" }
        return nil if main_publishers.empty?
        if main_publishers.length == 1
          main_publishers.first
        else
          raise ExpectsOneButHasSeveral, main_publishers.map(&:name)
        end
      end

      def imprint
        if @imprints.length > 0
          if @imprints.length==1
            @imprints.first
          else
            raise ExpectsOneButHasSeveral, @imprints.map(&:name)
          end
        else
          nil
        end
      end

      def publication_date
        pub=@publishing_dates.select{|pd| pd.role.human=="PublicationDate" or pd.role.human=="PublicationDateOfPrintCounterpart"}.first
        if pub
          pub.date
        else
          nil
        end
      end

      def embargo_date
        pub=@publishing_dates.select{|pd| pd.role.human=="EmbargoDate"}.first
        if pub
          pub.date
        else
          nil
        end
      end

      def preorder_embargo_date
        pub=@publishing_dates.select{|pd| pd.role.human=="PreorderEmbargoDate"}.first
        if pub
          pub.date
        else
          nil
        end
      end

      def public_announcement_date
        pub=@publishing_dates.select{|pd| pd.role.human=="PublicAnnouncementDate"}.first
        if pub
          pub.date
        else
          nil
        end
      end

      def status
        @publising_status
      end

      def city
        @city_of_publication
      end

      def country
        @country_of_publication
      end

    end
  end
end
