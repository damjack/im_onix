require 'onix/book/short_to_ref'

module Onix
  module Book
    class RefToShort
      def self.names
        @refnames ||= Onix::Book::ShortToRef.names.invert
      end
    end
  end
end