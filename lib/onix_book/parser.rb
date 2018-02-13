module OnixBook
  class Parser
    include OnixBook::Helpers::Converter

    attr_accessor :header, :products, :release

    def initialize
      @release = "2.1"
      @products = []
      @vault = {}
    end

    def vault
      @vault
    end

    def vault= v
      @vault = v
    end

    # merge another message in this one
    # current object erase other values
    def merge!(other)
      @products += other.products
      @products = @products.uniq { |p| p.ean }
      init_vault
      self
    end

    # keep products for which block return true
    def select! &block
      @products.select! { |p| block.call(p) }
      init_vault
      self
    end

    # initialize hash between ID and product object
    def init_vault
      @vault = {}
      @products.each do |product|
        product.identifiers.each do |identifier|
          @vault[identifier.uniq_id] = product
        end
      end

      @products.each do |product|
        product.related.each do |related|
          related.identifiers.each do |identifier|
            if @vault[identifier.uniq_id]
              related.product = @vault[identifier.uniq_id]
            end
          end
        end

        product.parts.each do |part|
          part.identifiers.each do |identifier|
            if @vault[identifier.uniq_id]
              part.product = @vault[identifier.uniq_id]
            end
          end
        end
      end
    end

    # open with arg detection
    def get(file)
      data = file_to_data(file)
      xml = Nokogiri::XML.parse(data)
      xml
    end

    # parse filename or file
    def analyze(arg)
      xml = get(arg)
      @products = []

      @release = xml.root["release"]
      xml.root.elements.each do |e|
        case e
          when OnixBook::Helpers::Matcher.new("Header")
            @header = OnixBook::Elements::Header.new().analyze(e)
          when OnixBook::Helpers::Matcher.new("Product")
            product=nil
            if @release =~ /^3.0/
              product = OnixBook::Elements::Product.new().analyze(e)
            else
              product = Product21.new().parse(e)
            end
            product.default_language_of_text = @header.default_language_of_text
            product.default_price_type_code = @header.default_price_type_code
            product.default_currency_code = @header.default_currency_code
            @products << product
        end
      end

      init_vault

      {header: @header, release: @release, products: @products}
    end

  end
end
