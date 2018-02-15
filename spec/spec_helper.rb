require_relative '../app.rb' #initialize a framework
require 'rspec'
require 'rack/test' #help up server
require 'ffaker' #generate randomic data
#require "pg_search" #search in database
Dir["./spec/support/**/*.rb"].each { |f| require f } #import packages autoload
Dir["./app/services/**/*.rb"].each {|file| require file }

set :environment, :test #set test

#include Methods for test
module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

#create a module inside the spec
RSpec.configure do |c|
  c.include RSpecMixin
  ActiveRecord::Base.logger = nil unless ENV['LOG'] == true
end
