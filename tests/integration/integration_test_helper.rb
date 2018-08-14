require 'capybara'
require 'capybara/dsl'
require 'capybara_minitest_spec'

Capybara.app = Sinatra::Application

class Capybara::Session
  def params
    Hash[*URI.parse(current_url).query.split(/\?|=|&/)]
  end
end

class MiniTest::Spec
  include Capybara::DSL
  include Rack::Test::Methods
end
