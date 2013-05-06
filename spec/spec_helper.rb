require 'active_record'
require 'utf8_serialize'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migration.verbose = false
load "schema.rb"
