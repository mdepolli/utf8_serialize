# encoding: utf-8

require 'spec_helper'

describe ActiveRecord::Base do
  it 'serializes like normal correctly' do
    name = "Cliff❡"

    product = Product.create!(:info => {:name => name})

    Product.find(product.id).info[:name].should == name
  end

  it 'fails pulling the data in the old way' do
    Product.destroy_all
    yaml = "--- \n:name: !binary |\n  YWNlIMSBxI3Ekw==\n\n"
    query = "INSERT INTO products (id,info) VALUES (1,'#{yaml}');"
    ActiveRecord::Base.connection.execute(query);

    name = "ace \xC4\x81\xC4\x8D\xC4\x93"

    result = Product.find(1).info[:name]
    result.should == name
  end

  it 'forces encodings for utf8' do
    Product.destroy_all
    yaml = "--- \n:name: !binary |\n  YWNlIMSBxI3Ekw==\n\n"
    query = "INSERT INTO products (id,info) VALUES (1,'#{yaml}');"
    ActiveRecord::Base.connection.execute(query);

    name = "ace āčē"

    result = Product.find(1).info[:name]
    result.should == name
    result.encoding.should == Encoding.find('UTF-8')
  end
end
