require 'ext/hash'
require 'active_record'
require 'utf_yaml_column'

module ActiveRecord
  module AttributeMethods
    module Serialization
      module ClassMethods
        def utf8_serialize(attr_name, class_name_or_coder = Object)
          include Behavior

          coder = if [:load, :dump].all? { |x| class_name_or_coder.respond_to?(x) }
                    class_name_or_coder
                  else
                    ActiveRecord::Coders::UTFYAMLColumn.new(class_name_or_coder)
                  end

          # merge new serialized attribute and create new hash to ensure that each class in inheritance hierarchy
          # has its own hash of own serialized attributes
          self.serialized_attributes = serialized_attributes.merge(attr_name.to_s => coder)
        end
      end
    end
  end
end
