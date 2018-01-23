module Onix
  module Book
    module Model
      class Website < SubsetDsl
        element "WebsiteRole", :subset
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
end
