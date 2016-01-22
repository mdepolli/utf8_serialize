require 'yaml'

module ActiveRecord # :stopdoc:
  module Coders
    class UTFYAMLColumn < YAMLColumn
      def load(yaml)
        return object_class.new if object_class != Object && yaml.nil?
        return yaml unless yaml.is_a?(String) && yaml =~ /^---/
        begin
          obj = YAML.load(yaml)

          unless obj.is_a?(object_class) || obj.nil?
            raise SerializationTypeMismatch,
                  "Attribute was supposed to be a #{object_class}, but was a #{obj.class}"
          end

          if yaml =~ /\!binary \|/ && obj.respond_to?(:to_utf8)
            obj = obj.to_utf8
          end

          obj ||= object_class.new if object_class != Object

          obj
        rescue *RESCUE_ERRORS
          yaml
        end
      end
    end
  end
end
