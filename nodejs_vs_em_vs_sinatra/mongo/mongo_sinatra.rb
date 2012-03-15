require 'rubygems'
require 'sinatra'
require 'mongo'

conn = Mongo::Connection.new("localhost", 27017, :pool_size => 100, :pool_timeout => 5)
db = conn['test']
set :collection, db['sinatra']

get '/' do
  settings.collection.insert({'name' => "hlxwell"})
end