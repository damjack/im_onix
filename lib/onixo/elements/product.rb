module Onixo
  module Elements
    class Product < Base
      include Onixo::Methods::Ean
      include Onixo::Methods::Isbn
      include Onixo::Methods::ProprietaryId
      include Onixo::Extractor::ProductSupplies

      # default LanguageCode from ONIXMessage
      attr_accessor :default_language_of_text
      # default code from ONIXMessage
      attr_accessor :default_currency_code
      # default price type from ONIXMessage
      attr_accessor :default_price_type_code

      element "RecordReference", :text
      elements "ProductIdentifier", :sub_element
      element "NotificationType", :yaml
      element "RecordSourceType", :yaml
      element "RecordSourceName", :text
      element "RelatedMaterial", :sub_element
      element "DescriptiveDetail", :sub_element
      element "CollateralDetail", :sub_element
      element "PublishingDetail", :sub_element
      elements "ProductSupply", :sub_element

      # shortcuts
      def identifiers
        @product_identifiers
      end

      # :category: High level
      # product title string
      def title
        @descriptive_detail.title
      end

      # :category: High level
      # product subtitle string
      def subtitle
        @descriptive_detail.subtitle
      end

      # :category: High level
      # product description string including HTML
      def description
        if @collateral_detail
          @collateral_detail.description
        else
          nil
        end
      end

      # :category: High level
      # product larger front cover URL string
      def frontcover_url
        if @collateral_detail
          @collateral_detail.frontcover_url
        end
      end

      # :category: High level
      # product larger front cover last updated date
      def frontcover_last_updated
        if @collateral_detail
          @collateral_detail.frontcover_last_updated
        end
      end

      # :category: High level
      # product larger front cover mimetype
      def frontcover_mimetype
        if @collateral_detail
          @collateral_detail.frontcover_mimetype
        end
      end

      # :category: High level
      # ePub sample URL string
      def epub_sample_url
        if @collateral_detail
          @collateral_detail.epub_sample_url
        end
      end

      # :category: High level
      # ePub sample last updated date
      def epub_sample_last_updated
        if @collateral_detail
          @collateral_detail.epub_sample_last_updated
        end
      end

      # :category: High level
      # ePub sample mimetype
      def epub_sample_mimetype
        if @collateral_detail
          @collateral_detail.epub_sample_mimetype
        end
      end

      # :category: High level
      # product edition number
      def edition_number
        @descriptive_detail.edition_number
      end

      # product LanguageCode of text
      def language_of_text
        @descriptive_detail.language_of_text || @default_language_of_text
      end

      # :category: High level
      # product language code string of text (eg: fre)
      def language_code_of_text
        if self.language_of_text
          self.language_of_text.code
        end
      end

      # :category: High level
      # product language name string of text (eg: French)
      def language_name_of_text
        if self.language_of_text
          self.language_of_text.human
        end
      end

      # :category: High level
      # publisher collection title
      def publisher_collection_title
        @descriptive_detail.publisher_collection_title
      end

      def subjects
        @descriptive_detail.subjects
      end

      # BISAC categories Subject
      def bisac_categories
        @descriptive_detail.bisac_categories
      end

      # :category: High level
      # BISAC categories identifiers string array (eg: FIC000000)
      def bisac_categories_codes
        self.bisac_categories.map{|c| c.code}.uniq
      end

      # CCE categories Subject
      def cce_categories
        @descriptive_detail.cce_categories
      end

      # :category: High level
      # CCE categories identifiers string array (eg: FIC000000)
      def cce_categories_codes
        self.cce_categories.map{|c| c.code}.uniq
      end

      # CLIL categories Subject
      def clil_categories
        @descriptive_detail.clil_categories
      end

      # :category: High level
      # CLIL categories identifier string array
      def clil_categories_codes
        self.clil_categories.map{|c| c.code}.uniq
      end

      # :category: High level
      # keywords string array
      def keywords
        @descriptive_detail.keywords
      end

      # :category: High level
      # Protection type string (None, Watermarking, Drm, AdobeDrm)
      def protection_type
        @descriptive_detail.protection_type
      end

      # :category: High level
      # List of protections type string (None, Watermarking, DRM, AdobeDRM)
      def protections
        @descriptive_detail.protections
      end

      # :category: High level
      # product has DRM ?
      def drmized?
        if @protections.any? {|p| p =~ /Drm/ }
          true
        else
          false
        end
      end

      # :category: High level
      # is product digital ?
      def digital?
        @descriptive_detail.digital?
      end

      # :category: High level
      # is product audio ?
      def audio?
        @descriptive_detail.audio?
      end

      # :category: High level
      # is product digital ?
      def streaming?
        @descriptive_detail.streaming?
      end

      # :category: High level
      # is product a bundle of multiple parts ?
      def bundle?
        @descriptive_detail.bundle?
      end

      def sold_separately?
        @product_supplies.map{|ps| ps.supply_details.map{|sd| sd.sold_separately?}.flatten}.flatten.uniq.first
      end

      # :category: High level
      # bundle ProductPart array
      def parts
        @descriptive_detail.parts
      end

      # :category: High level
      # digital file filesize in bytes
      def filesize
        @descriptive_detail.filesize
      end

      # :category: High level
      # audio formats array
      def audio_formats
        @descriptive_detail.audio_formats
      end

      # :category: High level
      # audio format string ()
      def audio_format
        @descriptive_detail.audio_format
      end

      # :category: High level
      # digital file format string (Epub,Pdf,Mobipocket)
      def file_format
        @descriptive_detail.file_format
      end

      def form_details
        @descriptive_detail.form_details
      end

      def reflowable?
        @descriptive_detail.reflowable?
      end

      # :category: High level
      # digital file mimetype (Epub,Pdf,Mobipocket)
      def file_mimetype
        @descriptive_detail.file_mimetype
      end

      # :category: High level
      # digital file description string
      def file_description
        @descriptive_detail.file_description
      end

      # :category: High level
      # raw file description string without HTML
      def raw_file_description
        if @descriptive_detail.file_description
          Onixo::Tools::Global.strip_html(@descriptive_detail.file_description).gsub(/\s+/," ").strip
        else
          nil
        end
      end

      # :category: High level
      # page count
      def pages
        @descriptive_detail.pages
      end

      # :category: High level
      # raw book description string without HTML
      def raw_description
        if self.description
          Onixo::Helpers::Converter.strip_html(self.description).gsub(/\s+/," ").strip
        else
          nil
        end
      end

      def publishers
        if @publishing_detail
          @publishing_detail.publishers
        else
          []
        end
      end

      def publisher
        if @publishing_detail
          @publishing_detail.publisher
        else
          nil
        end
      end

      # :category: High level
      # publisher name string, if multiple publishers are found, then they are concatenated with " / "
      def publisher_name
        if self.publishers.length > 0
          self.publishers.map{|p| p.name}.join(" / ")
        end
      end

      # :category: High level
      # publisher GLN string, nil if multiple publishers are found
      def publisher_gln
        if self.publishers.length==1
          self.publisher.gln
        end
      end

      def imprint
        if @publishing_detail
          @publishing_detail.imprint
        else
          nil
        end
      end

      # :category: High level
      # imprint name string
      def imprint_name
        if self.imprint
          self.imprint.name
        else
          nil
        end
      end

      # :category: High level
      # imprint GLN string
      def imprint_gln
        if self.imprint
          self.imprint.gln
        end
      end

      def distributors
        @product_supplies.map{|ps| ps.distributors}.flatten.uniq{|d| d.name}
      end

      # product distributor
      def distributor
        if self.distributors.length > 0
        if self.distributors.length==1
          self.distributors.first
        else
          raise ExpectsOneButHasSeveral, self.distributors.map(&:name)
        end
        else
          nil
        end
      end

      # :category: High level
      # product distributor name string
      def distributor_name
        if self.distributor
          self.distributor.name
        else
          nil
        end
      end

      # :category: High level
      # product distributor GLN string
      def distributor_gln
        if self.distributor
          self.distributor.gln
        else
          nil
        end
      end

      # :category: High level
      # return every related subset
      def related
        if @related_material
          (@related_material.related_products + @related_material.related_works)
        else
          []
        end
      end

      # :category: High level
      # paper linking RelatedProduct
      def part_of_product
        if @related_material
          @related_material.part_of_products.first
        end
      end

        # :category: High level
      # paper linking RelatedProduct
      def print_product
        if @related_material
          @related_material.print_products.first
        end
      end

      # DEPRECATED see print_product instead
      def paper_linking
        self.print_product
      end

      # :category: High level
      # date of publication
      def publication_date
        if @publishing_detail
          @publishing_detail.publication_date
        end
      end

      # date of embargo
      def embargo_date
        if @publishing_detail
          @publishing_detail.embargo_date
        end
      end

      def preorder_embargo_date
        if @publishing_detail
          @publishing_detail.preorder_embargo_date
        end
      end

      def public_announcement_date
        if @publishing_detail
          @publishing_detail.public_announcement_date
        end
      end

      def sales_restriction
        if @publishing_detail
          @publishing_detail.sales_restriction
        end
      end

      # :category: High level
      # product countries rights string array
      def countries_rights
        countries=[]
        if @publishing_detail
          countries+=@publishing_detail.sales_rights.map{|sr| sr.territory.countries}.flatten.uniq
        end

        if @product_supplies
          countries+=@product_supplies.map{|ps| ps.markets.map{|m| m.territory.countries}.flatten}.flatten.uniq
        end

        countries.uniq
      end

      # :category: High level
      def illustrations
        return [] unless @collateral_detail && @collateral_detail.supporting_resources

        @collateral_detail.supporting_resources.select {|sr| sr.mode.human=='Image'}.map do |image_resource|
          {
            :url => image_resource.versions.last.links.first.strip,
            :type => image_resource.type.human,
            :width => image_resource.versions.last.image_width,
            :height => image_resource.versions.last.image_height,
            :caption => image_resource.caption,
            :format_code => image_resource.versions.last.file_format,
            :updated_at => image_resource.versions.last.last_updated_utc
          }
        end
      end

      # :category: High level
      def excerpts
        return [] unless @collateral_detail && @collateral_detail.supporting_resources

        @collateral_detail.supporting_resources.select {|sr| (sr.mode.human=='Text' || sr.mode.human='Multimode') && sr.type.human=='SampleContent'}.map do |resource|
          {
            :url => resource.versions.last.links.first.strip,
            :form => resource.versions.last.form.human,
            :md5 => resource.versions.last.md5_hash,
            :format_code => resource.versions.last.file_format,
            :updated_at => resource.versions.last.last_updated_utc
          }
        end
      end

      def available_product_supplies
        @product_supplies.select{|ps| ps.available?}
      end

      # :category: High level
      # is product available ?
      def available?
        self.available_product_supplies.length > 0 and not self.delete?
      end

      # :category: High level
      # is product available for given +country+ ?
      def available_for_country?(country)
        self.supplies_for_country(country).select{|s| s[:available]}.length > 0 and self.available?
      end

      # :category: High level
      # is product price to be announced ?
      def price_to_be_announced?
        unless self.product_supplies.empty? || self.product_supplies.first.supply_details.empty?
          unpriced_item_type = self.product_supplies.first.supply_details.first.unpriced_item_type
        end
        unpriced_item_type ? unpriced_item_type.human=="PriceToBeAnnounced" : false
      end

      # :category: High level
      # is a deletion notification ?
      def delete?
        self.notification_type.human == "Delete"
      end

      # :category: High level
      # Contributor array
      def contributors
        @descriptive_detail.contributors
      end

      # :category: High level
      # List of ONIX outlets values
      def onix_outlets_values
        if @publishing_detail
          @publishing_detail.sales_rights.map { |sri|
            sri.sales_restrictions.select { |sr| (!sr.start_date or sr.start_date <= Date.today) and (!sr.end_date or sr.end_date >= Date.today) }.map { |sr|
              sr.sales_outlets.select { |so|
                so.identifier and so.identifier.type.human=="OnixSalesOutletIdCode" }.map { |so| so.identifier.value } } }.flatten
        else
          []
        end
      end

      def parse(n)
        super
        parts.each do |part|
          part.part_of = self
        end if parts
      end

    end
  end
end
