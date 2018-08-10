ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

module MiniTest
  class Test
    include Rack::Test::Methods
  end
end

def app
  Sinatra::Application
end
