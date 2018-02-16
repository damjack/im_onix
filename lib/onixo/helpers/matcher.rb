module Onixo
  module Helpers
    Matcher = Struct.new(:tag_name) do
      def ===(target)
        if target.element?
          name = target.name
          loader = Onixo::Data::Loader.new()
          name.casecmp(tag_name) == 0 || loader.short_names(name) == tag_name
        else
          false
        end
      end
    end
  end
end
