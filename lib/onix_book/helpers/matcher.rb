module OnixBook
  module Helpers
    Matcher = Struct.new(:tag_name) do
      def ===(target)
        if target.element?
          name = target.name
          name.casecmp(tag_name) == 0 or OnixBook::Data::Loader.short_names[name] == tag_name
        else
          false
        end
      end
    end
  end
end
