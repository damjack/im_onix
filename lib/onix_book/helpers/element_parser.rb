module OnixBook
  module Helpers
    class ElementParser
      attr_accessor :type, :name

      def self.inflectors
        [
          ['ox', 'oxes'],
          ['us', 'uses'],
          ['', 's'],
          ['ero', 'eroes'],
          ['rf', 'rves'],
          ['af', 'aves'],
          ['ero', 'eroes'],
          ['man', 'men'],
          ['ch', 'ches'],
          ['sh', 'shes'],
          ['ss', 'sses'],
          ['ta', 'tum'],
          ['ia', 'ium'],
          ['ra', 'rum'],
          ['ay', 'ays'],
          ['ey', 'eys'],
          ['oy', 'oys'],
          ['uy', 'uys'],
          ['y', 'ies'],
          ['x', 'xes'],
          ['lf', 'lves'],
          ['ffe', 'ffes'],
          ['afe', 'aves'],
          ['ouse', 'ouses']
        ]
      end

      def initialize(name, type, options={})
        @name = name
        @type = type
        @pluralize = true
        @array = false
        @lambda = nil
        if options[:array]
          @array = true
        end
        if options[:pluralize] == false
          @pluralize = false
        end
        if options[:lambda]
          @lambda = options[:lambda]
        end
        if options[:klass]
          @klass_name = options[:klass]
        else
          @klass_name = name
        end
      end

      def lambda(v)
        if @lambda
          @lambda.call(v)
        else
          v
        end
      end

      def is_array?
        @array
      end

      def _underscore_name
        if @array and @pluralize
          pluralize(underscore(@name))
        else
          underscore(@name)
        end
      end

      def underscore_name
        @underscore_name ||= _underscore_name
      end

      def class_name
        @klass_name
      end

      def to_sym
        @sym ||= self.underscore_name.to_sym
      end

      def to_instance
        @instance ||= "@"+self.underscore_name
      end

      private
      def pluralize(str)
        rex = /(#{self.class.inflectors.map { |si, pl| si }.join('|')})$/i
        hash = Hash[*self.class.inflectors.flatten]
        str.sub(rex) { |m| hash[m] }
      end

      def underscore(str)
        word = str.to_s.dup
        word.gsub!('::', '/')
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word
      end
    end
  end
end
