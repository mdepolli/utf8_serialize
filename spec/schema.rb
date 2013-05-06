ActiveRecord::Schema.define(:version => 0) do

  create_table :products, :force => true do |t|
    t.text :info
  end

end

class Product < ActiveRecord::Base
  utf8_serialize :info, Hash
end

class OldProduct < ActiveRecord::Base
  self.table_name = 'products'
  serialize :info, Hash
end
