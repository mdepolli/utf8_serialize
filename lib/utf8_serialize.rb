require 'ext/hash'
require 'active_record'
require 'utf_yaml_column'

ActiveRecord::Base.instance_eval do
  def utf8_serialize(attr_name, class_name = Object)
    coder = ActiveRecord::Coders::UTFYAMLColumn.new(class_name)

    # merge new serialized attribute and create new hash to ensure that each class in inheritance hierarchy
    # has its own hash of own serialized attributes
    self.serialized_attributes = serialized_attributes.merge(attr_name.to_s => coder)
  end
end
