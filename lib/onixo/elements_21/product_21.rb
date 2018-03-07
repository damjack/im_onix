  module Onixo
    module Elements21
      # ONIX 2.1 elements
      class Title < Base21
        element "TitleType", :yaml_21
        element "TitleText", :text
        element "TitlePrefix", :text
        element "TitleWithoutPrefix", :text
        element "AbbreviatedLength", :integer
        element "Subtitle", :text

        def type
          @title_type
        end

        def title
          @title_text
        end
      end

      class OtherText < Base21
        element "TextTypeCode", :yaml_21
        element "TextFormat", :text
        element "Text", :text

        def type
          @text_type_code
        end
      end

      class MediaFile < Base21
        element "MediaFileTypeCode", :yaml_21
        element "MediaFileFormatCode", :yaml_21
        element "MediaFileLinkTypeCode", :yaml_21
        element "MediaFileLink", :text

        def type
          @media_file_type_code
        end

        def format
          @media_file_format_code
        end

        def link_type
          @media_file_link_type_code
        end

        def link
          @media_file_link
        end
      end

      class Territory < Base21
        attr_accessor :countries

        def initialize(countries)
          @countries=countries
        end

        def +v
          Territory.new((@countries + v.countries).uniq)
        end

        def -v
          Territory.new((@countries - v.countries).uniq)
        end
      end

      class Supplier < Base21
        attr_accessor :name
        attr_accessor :role

        def initialize(name,role)
          @name = name
          @role = role
        end

        def identifiers
          []
        end

        def websites
          []
        end
      end

      class SupplyDetail < Base21
        # TODO
        # convert OnSaleDate to Date.strptime()
        element "SupplierName", :text
        element "TelephoneNumber", :text
        element "SupplierRole", :text

        element "AvailabilityCode", :text
        element "ProductAvailability", :text
        element "OnSaleDate", :text, {:lambda => lambda { |v| v }}
        elements "Price", :sub_element

        def availability_date
          @on_sale_date
        end

        def available?
          @product_availability=="20" or @availability_code == "IP"
        end

        def suppliers
          [Supplier.new(self.supplier_name,self.supplier_role)]
        end
      end

      class SalesRights < Base21
        element "SalesRightsType", :text
        element "RightsCountry", :text

        def not_for_sale?
          ["03","04","05","06"].include?(@sales_rights_type)
        end

        def territory
          Territory.new(@rights_country.split(" "))
        end
      end

      class NotForSale < Base21
        element "RightsCountry", :text

        def territory
          Territory.new(@rights_country.split(" "))
        end
      end

      class RelatedProduct < Base21
        include Onixo::Methods::Ean
        include Onixo::Methods::ProprietaryId

        element "RelationCode", :text
        elements "ProductIdentifier", :sub_element

        def product=v
        end

        def identifiers
          @product_identifiers
        end

        def code
          @relation_code
        end
      end

      class MainSubject < Base21
        element "SubjectCode", :text
        element "SubjectHeadingText", :text
        element "MainSubjectSchemeIdentifier", :sub_element, :klass=>"SubjectSchemeIdentifier"
        element "SubjectSchemeName", :text
        element "SubjectSchemeVersion", :text

        # shortcuts
        def code
          @subject_code
        end

        def heading_text
          @subject_heading_text
        end

        def scheme_identifier
          @main_subject_scheme_identifier
        end

        def scheme_name
          @subject_scheme_name
        end

        def scheme_version
          @subject_scheme_version
        end
      end

      class Product < Base21
        include Onixo::Methods::Ean
        include Onixo::Methods::ProprietaryId

        element "RecordReference", :text
        elements "ProductIdentifier", :sub_element
        element "NotificationType", :yaml_21
        element "RecordSourceName", :text
        elements "Title", :sub_element
        elements "ProductSupply", :sub_element

        elements "Contributor", :sub_element
        element "ContributorStatement", :text

        elements "Extent", :sub_element
        elements "Language", :sub_element
        elements "MediaFile", :sub_element

        element "NumberOfPages", :text

        elements "Publisher", :sub_element
        elements "Imprint", :sub_element

        element "ProductForm", :text

        elements "OtherText", :sub_element

        elements "SalesRights", :sub_element, {:pluralize => false}
        elements "NotForSale", :sub_element

        element "BASICMainSubject", :text
        elements "MainSubject", :sub_element
        elements "Subject", :sub_element

        element "PublishingStatus", :text
        element "PublicationDate", :text, {:lambda => lambda { |v| v }}

        elements "RelatedProduct", :sub_element

        elements "SupplyDetail", :sub_element

        element "EpubType", :yaml_21
        element "EpubTypeDescription", :text
        element "EpubFormat", :text
        element "EpubTypeNote", :text

        element "EditionNumber", :integer
        element "NoEdition", :ignore
        element "NoSeries", :ignore

        # shortcuts
        def identifiers
          @product_identifiers
        end

        # default LanguageCode from ONIXMessage
        attr_accessor :default_language_of_text
        # default code from ONIXMessage
        attr_accessor :default_currency_code
        # default price type from ONIXMessage
        attr_accessor :default_price_type_code

        def title
          product_title.title
        end

        # :category: High level
        # product subtitle string
        def subtitle
          product_title.subtitle
        end

        def product_title
          @titles.select { |td| td.type.human=~/DistinctiveTitle/ }.first
        end

        def bisac_categories_codes
          cats=[]
          if @basic_main_subject
            cats << @basic_main_subject
          end
          cats+=(@main_subjects + @subjects).select { |s| s.scheme_identifier.human=="BisacSubjectHeading" }.map{|s| s.code}
          cats
        end

        def cce_categories_codes
          (@main_subjects + @subjects).select { |s| s.scheme_identifier.human=="SoggettoCce" }.map{|s| s.code}
        end

        def clil_categories_codes
          (@main_subjects + @subjects).select { |s| s.scheme_identifier.human=="Clil" }.map{|s| s.code}
        end

        def keywords
          kws=(@main_subjects + @subjects).select { |s| s.scheme_identifier.human=="Keywords" }.map { |kw| kw.heading_text }.compact
          kws.map { |kw| kw.split(/;|,|\n/) }.flatten.map { |kw| kw.strip }
        end

        # doesn't apply
        def onix_outlets_values
          []
        end

        # product LanguageCode of text
        def language_of_text
          lang=nil
          l=@languages.select { |l| l.role.human=="LanguageOfText" }.first
          if l
            lang=l.code
          end
          lang || @default_language_of_text
        end

        def language_code_of_text
          if self.language_of_text
            self.language_of_text.code
          end
        end

        def language_name_of_text
          if self.language_of_text
            self.language_of_text.human
          end
        end

        def publisher_name
          if @publishers.first
            @publishers.first.name
          end
        end

        def imprint_name
          if @imprints.first
            @imprints.first.name
          end
        end

        # doesn't apply
        def sold_separately?
          true
        end

        def description
          desc_contents=@other_texts.select{|tc| tc.type.human=="MainDescription"} + @other_texts.select{|tc| tc.type.human=="LongDescription"} + @other_texts.select{|tc| tc.type.human=="ShortDescriptionannotation"}
          if desc_contents.length > 0
            desc_contents.first.text
          else
            nil
          end
        end

        def raw_description
          if self.description
            Helper.strip_html(self.description).gsub(/\s+/, " ").strip
          else
            nil
          end
        end

        def product_supplies
          [self]
        end

        def countries
          territory=Territory.new(CountryCode.list)
          @sales_rights.each do |sr|
            if sr.not_for_sale?
              territory=territory-sr.territory
            else
              territory=territory+sr.territory
            end
          end

          @not_for_sales.each do |sr|
            territory=territory-sr.territory
          end

          territory.countries
        end

        def availability_date
          nil
        end

        def embargo_date
          nil
        end

        def preorder_embargo_date
          nil
        end

        def public_announcement_date
          nil
        end

        include Onixo::Extractor::ProductSupplies

        def related
          @related_products
        end

        # doesn't apply
        def parts
          []
        end

        # doesn't apply
        def bundle?
          false
        end

        def digital?
          @product_form=="DG"
        end

        def available?
          @supply_details.select { |sd| sd.available? }.length > 0
        end

        def available_for_country?(country)
          self.supplies_for_country(country).select{|s| s[:available]}.length > 0 and self.available?
        end

        def pages
          if @number_of_pages
            @number_of_pages.to_i
          end
        end

        def edition_number
          @edition_number
        end

        def distributor_name
          nil
        end

        def frontcover_url
          fc=@media_files.select { |mf| mf.media_file_type_code.human=="ImageFrontCover" && mf.media_file_link_type_code.human=="Url"}
          if fc.length > 0
            fc.first.link
          else
            nil
          end
        end

        # TODO
        def publisher_collection_title
          nil
        end

        def file_format
          @epub_type.human
        end

        def file_description
          @epub_type_description
        end

        def raw_file_description
          file_description
        end

        # doesn't apply
        def filesize
          nil
        end

        # doesn't apply
        def protection_type
          nil
        end

        def epub_sample_url
          nil
        end

        def print_product
          @related_products.select { |rp| rp.code=="13" }.first
        end

        # DEPRECATED see print_product instead
        def paper_linking
          self.print_product
        end

        def publisher_gln
          nil
        end

        def method_missing(method)
          raise "WARN #{method} not found"
        end

      end
    end
  end
