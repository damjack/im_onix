module Onixo
  module Elements
    class Website < Base
      element "WebsiteRole", :sub_element
      element "WebsiteLink", :text
      element "WebsiteDescription", :text

      # shortcuts
      def role
        @website_role
      end

      def link
        @website_link
      end

      def description
        @website_description
      end
    end
  end
end
