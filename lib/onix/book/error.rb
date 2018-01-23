module Onix
  module Book
    class SubsetUnsupported < StandardError
    end

    class ExpectsOneButHasSeveral < StandardError
    end
  end
end