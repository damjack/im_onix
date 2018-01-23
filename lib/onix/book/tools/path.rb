module Onix
  module Book
    module Tools
      module Path

        attr_writer :data_path
        attr_writer :code_lists_path
        attr_writer :code_lists21_path

        def data_path
          @data_path || Onix::Book.data_path
        end

        def code_lists_path
          @code_lists_path || File.join(data_path, "onix30", "lists")
        end

        def code_lists21_path
          @code_lists21_path || File.join(data_path, "onix21", "lists")
        end

      end
    end
  end
end