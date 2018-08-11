require 'sinatra'
require 'sinatra/contrib/all' if development?

require_relative 'controllers/categories_controller'
require_relative 'controllers/merchants_controller'
require_relative 'controllers/transactions_controller'
require_relative 'controllers/users_controller'
require_relative 'models/user'

also_reload('models/*') if development?

helpers do
  def current_user_id
    User.all.first.id
  end
end

get '/' do
  erb :home
end
