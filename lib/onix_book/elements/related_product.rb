module OnixBook
  module Elements
    class RelatedProduct < Base
      include OnixBook::Methods::Ean
      include OnixBook::Methods::ProprietaryId

      element "ProductRelationCode", :yaml
      elements "ProductIdentifier", :sub_element
      element "ProductForm", :sub_element
      elements "ProductFormDetail", :sub_element

      # shortcuts
      def code
        @product_relation_code
      end

      def identifiers
        @product_identifiers
      end

      def form
        @product_form
      end

      def form_details
        @product_form_details
      end

      # full Product if referenced in ONIXMessage
      def product
        @product
      end

      def product=v
        @product=v
      end

      def file_format
        file_formats.first.human if file_formats.first
      end

      def file_formats
        @product_form_details.select{|fd| fd.code =~ /^E1.*/}
      end
    end
  end
end
