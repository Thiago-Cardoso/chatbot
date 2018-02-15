require_relative '../app.rb' #initialize a framework
require 'rspec'
require 'rack/test' #help up server

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
end
