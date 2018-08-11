require 'sinatra'
require 'sinatra/contrib/all' if development?

require_relative 'controllers/merchants_controller'
require_relative 'models/user'

also_reload('models/*') if development?

get '/' do
  @users = User.all
  erb :home
end

get '/users/:id' do
  @user = User.find_by_id(params['id'])
  erb :user
end
