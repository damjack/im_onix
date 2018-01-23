require 'onix/book/subset'

module Onix
  module Book
    class Code < Subset
      attr_accessor :code
      attr_accessor :human

      def parse(n)
        @code=n.text
        @human=self.class.hash[n.text]
      end

      # create Code from string ONIX code
      def self.from_code(code)
        o=self.new
        o.code=code
        o.human=self.hash[code]
        o
      end

      # create Code from humanized string code
      def self.from_human(human)
        o=self.new
        o.human=human
        o.code=self.hash.key(human)
        o
      end

      # Humanized string code
      def human
        @human
      end

      # ONIX code
      def onix
        @code
      end

      private
      def self.hash
        {}
      end

    end
  end
end
