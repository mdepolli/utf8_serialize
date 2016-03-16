require 'ext/hash'
require 'active_record'
require 'utf_yaml_column'

module ActiveRecord
  module AttributeMethods
    module Serialization
      module ClassMethods
        def utf8_serialize(attr_name, class_name_or_coder = Object)
          coder = if class_name_or_coder == ::JSON
                    Coders::JSON
                  elsif [:load, :dump].all? { |x| class_name_or_coder.respond_to?(x) }
                    class_name_or_coder
                  else
                    Coders::YAMLColumn.new(class_name_or_coder)
                  end

          decorate_attribute_type(attr_name, :serialize) do |type|
            Type::Serialized.new(type, coder)
          end

          # merge new serialized attribute and create new hash to ensure that each class in inheritance hierarchy
          # has its own hash of own serialized attributes
          self.serialized_attributes = serialized_attributes.merge(attr_name.to_s => coder)
        end
      end
    end
  end
end
