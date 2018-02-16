module Onixo
  module Elements
    class ResourceVersionFeature < Base
      element "ResourceVersionFeatureType", :yaml
      elements "FeatureNote", :text
      element "FeatureValue", :text

      def type
        @resource_version_feature_type
      end

      def value
        @feature_value
      end

      def notes
        @feature_notes
      end

      def parse(n)
        super

        if @resource_version_feature_type.human=="FileFormat"
          @feature_value=SupportingResourceFileFormat.from_code(@feature_value)
        end
      end
    end

    class ResourceVersion < Base
      element "ResourceForm", :yaml
      elements "ResourceLink", :text
      elements "ContentDate", :sub_element
      elements "ResourceVersionFeature", :sub_element

      # shortcuts
      def form
        @resource_form
      end

      def links
        @resource_links
      end

      def features
        @resource_version_features
      end

      def filename
        if @resource_form.human=="DownloadableFile"
          @resource_links.first
        end
      end

      def file_format_feature
        @resource_version_features.select { |f| f.type.human=="FileFormat" }.first
      end

      def file_format
        if ["DownloadableFile", "LinkableResource"].include?(@resource_form.human)
          if file_format_feature
            file_format_feature.value.human
          end
        end
      end

      def file_mimetype
        if ["DownloadableFile", "LinkableResource"].include?(@resource_form.human)
          if file_format_feature
            file_format_feature.value.mimetype
          end
        end
      end

      def image_width_feature
        @resource_version_features.select { |i| i.type.human=="ImageWidthInPixels" }.first
      end

      def image_height_feature
        @resource_version_features.select { |i| i.type.human=="ImageHeightInPixels" }.first
      end

      def md5_hash_feature
        @resource_version_features.select { |i| i.type.human=="Md5HashValue" }.first
      end

      def image_width
        if self.image_width_feature
          self.image_width_feature.value.to_i
        end
      end

      def image_height
        if self.image_height_feature
          self.image_height_feature.value.to_i
        end
      end

      def md5_hash
        if self.md5_hash_feature
          self.md5_hash_feature.value
        end
      end

      def last_updated_content_date
        @content_dates.select { |cd| cd.role.human=="LastUpdated" && cd.date }.first
      end

      def last_updated
        if self.last_updated_content_date
          self.last_updated_content_date.date
        end
      end

      def last_updated_utc
        if self.last_updated_content_date
          self.last_updated_content_date.date.to_time.utc.strftime('%Y%m%dT%H%M%S%z')
        end
      end
    end

    class ResourceFeature < Base
      element "ResourceFeatureType", :sub_element
      element "FeatureValue", :text
      elements "FeatureNotes", :text

      # shortcuts
      def type
        @resource_feature_type
      end

      def value
        @feature_value
      end

      def notes
        @feature_notes
      end
    end

    class SupportingResource < Base
      element "ResourceContentType", :yaml
      element "ContentAudience", :yaml
      element "ResourceMode", :yaml
      elements "ResourceVersion", :sub_element
      elements "ResourceFeature", :sub_element

      # shortcuts
      def type
        @resource_content_type
      end

      def mode
        @resource_mode
      end

      def versions
        @resource_versions
      end

      def features
        @resource_features
      end

      def caption_feature
        self.features.select{|i| i.type.human=="Caption"}.first
      end

      def caption
        if self.caption_feature
          self.caption_feature.value
        end
      end

      def target_audience
        @content_audience
      end

    end
  end
end
