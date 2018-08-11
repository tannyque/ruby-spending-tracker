require 'sinatra'
require 'sinatra/contrib/all' if development?

require_relative 'controllers/categories_controller'
require_relative 'controllers/merchants_controller'
require_relative 'controllers/users_controller'
require_relative 'models/user'

also_reload('models/*') if development?

get '/' do
  @users = User.all
  erb :home
end
