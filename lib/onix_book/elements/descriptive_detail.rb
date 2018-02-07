module OnixBook
  module Elements
    class TitleElement < Base
      element "TitleElementLevel", :yaml
      element "TitleText", :text
      element "TitlePrefix", :text
      element "TitleWithoutPrefix", :text
      element "Subtitle", :text
      element "PartNumber", :integer
      element "SequenceNumber", :integer

      # shortcuts
      def level
        @title_element_level
      end

      # :category: High level
      # flatten title string
      def title
        if @title_text
          @title_text
        else
          if @title_without_prefix
            if @title_prefix
              "#{@title_prefix} #{@title_without_prefix}"
            else
              @title_without_prefix
            end
          end
        end
      end
    end

    class TitleDetail < Base
      element "TitleType", :yaml
      elements "TitleElement", :sub_element

      def type
        @title_type
      end
    end

    class Collection < Base
      element "CollectionType", :sub_element
      elements "CollectionIdentifier", :sub_element
      elements "TitleDetail", :sub_element

      # shortcuts
      def type
        @collection_type
      end

      def identifiers
        @collection_identifiers
      end

      # :category: High level
      # collection title string
      def title
        if collection_title_element
          collection_title_element.title
        end
      end

      # :category: High level
      # collection subtitle string
      def subtitle
        if collection_title_element
          collection_title_element.subtitle
        end
      end

      def collection_title_element
        distinctive_title=@title_details.select { |td| td.type.human=~/DistinctiveTitle/}.first
        if distinctive_title
          distinctive_title.title_elements.select { |te| te.level.human=~/CollectionLevel/ or te.level.human=~/Subcollection/ }.first
        end
      end

    end

    # product part use full Product to provide file protection and file size
    class ProductPart < Base
      include OnixBook::Helpers::Converter
      include OnixBook::Methods::Ean
      include OnixBook::Methods::ProprietaryId

      elements "ProductIdentifier", :sub_element
      element "ProductForm", :yaml
      element "ProductFormDescription", :text
      elements "ProductFormDetail", :yaml
      elements "ProductContentType", :yaml
      element "NumberOfCopies", :integer

      # shortcuts
      def identifiers
        @product_identifiers
      end

      def form
        @product_form
      end

      def form_details
        @product_form_details
      end

      def content_types
        @product_content_types
      end

      # full Product if referenced in ONIXMessage
      def product
        @product
      end

      def product=v
        @product=v
      end

      # this ProductPart is part of Product
      def part_of
        @part_of
      end

      def part_of=v
        @part_of=v
      end

      # :category: High level
      # digital file format string (Epub,Pdf,AmazonKindle)
      def file_format
        self.file_formats.first.human if self.file_formats.first
      end

      def file_mimetype
        if self.file_formats.first
          self.file_formats.first.mimetype
        end
      end

      def file_formats
        @product_form_details.select { |fd| fd.code =~ /^E1.*/ }
      end

      def reflowable?
        return true if @product_form_details.select { |fd| fd.code == "E200" }.length > 0
        return false if @product_form_details.select { |fd| fd.code == "E201" }.length > 0
      end

      # :category: High level
      # part file description string
      def file_description
        @product_form_description
      end

      # :category: High level
      # raw part file description string without HTML
      def raw_file_description
        if @product_form_description
          strip_html(@product_form_description).gsub(/\s+/, " ").strip
        else
          nil
        end
      end

      # :category: High level
      # Protection type string (None, Watermarking, DRM, AdobeDRM)
      def protection_type
        if product
          product.protection_type
        else
          if part_of
            part_of.protection_type
          else
            nil
          end
        end
      end

      # :category: High level
      # List of protections type string (None, Watermarking, DRM, AdobeDRM)
      def protections
        if product
          product.protections
        else
          if part_of
            part_of.protections
          else
            nil
          end
        end
      end

      # :category: High level
      # digital file filesize in bytes
      def filesize
        if product
          product.filesize
        else
          nil
        end
      end
    end

    class Extent < Base
      element "ExtentType", :yaml
      element "ExtentUnit", :yaml
      element "ExtentValue", :text

      # shortcuts
      def type
        @extent_type
      end

      def unit
        @extent_unit
      end

      def value
        @extent_value
      end

      def bytes
        case @extent_unit.human
          when "Bytes"
            @extent_value.to_i
          when "Kbytes"
            (@extent_value.to_f*1024).to_i
          when "Mbytes"
            (@extent_value.to_f*1024*1024).to_i
          else
            nil
        end
      end

      def pages
        if @extent_unit.human=="Pages"
          @extent_value.to_i
        else
          nil
        end
      end
    end

    class EpubUsageLimit < Base
      element "EpubUsageUnit", :sub_element
      element "Quantity", :integer

      def unit
        @epub_usage_unit
      end
    end

    class EpubUsageConstraint < Base
      element "EpubUsageType", :sub_element
      element "EpubUsageStatus", :sub_element
      elements "EpubUsageLimit", :sub_element

      # shortcuts
      def type
        @epub_usage_type
      end

      def status
        @epub_usage_status
      end

      def limits
        @epub_usage_limits
      end
    end

    class Language < Base
      element "LanguageRole", :yaml
      element "LanguageCode", :yaml

      # shortcuts
      def role
        @language_role
      end

      def code
        @language_code
      end
    end

    class ProductFormFeature < Base
      element "ProductFormFeatureType", :sub_element
      element "ProductFormFeatureValue", :text
      elements "ProductFormFeatureDescription", :text

      # shortcuts
      def type
        @product_form_feature_type
      end

      def value
        @product_form_feature_value
      end

      def descriptions
        @product_form_feature_descriptions
      end
    end

    class DescriptiveDetail < Base
      elements "TitleDetail", :sub_element
      elements "Contributor", :sub_element
      elements "Collection", :sub_element
      elements "Extent", :sub_element
      element "EditionNumber", :integer
      element "EditionType", :yaml
      elements "Language", :sub_element
      element "ProductComposition", :yaml
      element "ProductForm", :yaml
      elements "ProductFormFeature", :sub_element
      element "ProductFormDescription", :text
      elements "ProductFormDetail", :yaml
      element "PrimaryContentType", :yaml, {:klass=>"ProductContentType"}
      elements "ProductContentType", :yaml
      elements "EpubTechnicalProtection", :yaml
      elements "EpubUsageConstraint", :sub_element
      elements "AudienceCode", :yaml
      elements "ProductPart", :sub_element
      elements "Subject", :sub_element
      element "NoEdition", :ignore
      element "NoCollection", :ignore


      # shortcuts
      def form
        @product_form
      end

      def form_details
        @product_form_details
      end

      def form_features
        @product_form_features
      end

      def composition
        @product_composition
      end

      def parts
        @product_parts
      end

      def content_types
        @product_content_types
      end

      # :category: High level
      # product title string
      def title
        product_title_element.title
      end

      # :category: High level
      # product subtitle string
      def subtitle
        product_title_element.subtitle
      end

      def product_title_element
        @title_details.select { |td| td.type.human=~/DistinctiveTitle/ }.first.title_elements.select { |te| te.level.human=~/Product/ }.first
      end

      def pages_extent
        @extents.select { |e| e.type.human=~/PageCount/ || e.type.human=~/NumberOfPage/ }.first
      end

      def pages
        if pages_extent
          pages_extent.pages
        else
          nil
        end
      end

      def filesize_extent
        @extents.select { |e| e.type.human=="Filesize" }.first
      end

      def filesize
        if filesize_extent
          filesize_extent.bytes
        else
          nil
        end
      end

      def digital?
        if @product_form and @product_form.human=~/Digital/
          true
        else
          false
        end
      end

      def streaming?
        @product_form.code=="EC"
      end

      def audio?
        not audio_formats.empty?
      end

      def audio_format
        self.audio_formats.first.human if self.audio_formats.first
      end

      def audio_formats
        @product_form_details.select { |fd| fd.code =~ /^A.*/ }
      end

      def bundle?
        @product_composition.human=="MultipleitemRetailProduct"
      end

      def file_format
        self.file_formats.first.human if self.file_formats.first
      end

      def file_mimetype
        if self.file_formats.first
          self.file_formats.first.mimetype
        end
      end

      def file_formats
        @product_form_details.select { |fd| fd.code =~ /^E1.*/ }
      end

      def reflowable?
        return true if @product_form_details.select { |fd| fd.code == "E200" }.length > 0
        return false if @product_form_details.select { |fd| fd.code == "E201" }.length > 0
      end

      def file_description
        @product_form_description
      end

      def protection_type
        if @epub_technical_protections.length > 0
          if @epub_technical_protections.length == 1
            @epub_technical_protections.first.human
          else
            raise ExpectsOneButHasSeveral, @epub_technical_protections.map(&:human)
          end
        end
      end

      def protections
        return nil if @epub_technical_protections.length == 0

        @epub_technical_protections.map(&:human)
      end

      def language_of_text
        l=@languages.select { |l| l.role.human=="LanguageOfText" }.first
        if l
          l.code
        else
          nil
        end
      end

      def publisher_collection
        @collections.select { |c| c.type.human=="PublisherCollection" }.first
      end

      def publisher_collection_title
        if self.publisher_collection
          self.publisher_collection.title
        end
      end

      def bisac_categories
        @subjects.select { |s| s.scheme_identifier.human=="BisacSubjectHeading" }
      end

      def cee_categories
        @subjects.select { |s| s.scheme_identifier.human=="SoggettoCce" }
      end

      def proprietary_categories
        @subjects.select { |s| s.scheme_identifier.human=="ProprietarySubjectScheme" }
      end

      def clil_categories
        @subjects.select { |s| s.scheme_identifier.human=="Clil" }
      end

      def keywords
        kws=@subjects.select { |s| s.scheme_identifier.human=="Keywords" }.map { |kw| kw.heading_text }.compact
        kws=kws.flat_map { |kw| kw.split(/;|,|\n/) }.map { |kw| kw.strip }
        kws.reject!{|k| k==""}
        kws
      end
    end
  end
end
