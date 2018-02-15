require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

#create app and import base for sinatra
class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
