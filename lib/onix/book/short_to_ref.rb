module Onix
  module Book
    class ShortToRef
      def self.names
        @shortnames ||= YAML.load(File.read(File.join(File.dirname(__FILE__), "data", "onix30", "shortnames.yml")))
      end
    end
  end
end