require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

# Load Models
Dir["./app/models/*.rb"].each {|file| require file }

#create app and import base for sinatra
class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
