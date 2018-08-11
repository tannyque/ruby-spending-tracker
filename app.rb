require 'sinatra'
require 'sinatra/contrib/all' if development?

require_relative 'models/user'
require_relative 'models/merchant'

also_reload('models/*') if development?

get '/' do
  @users = User.all
  erb :home
end

get '/users/:id' do
  @user = User.find_by_id(params['id'])
  erb :user
end

get '/merchants' do
  @merchants = Merchant.all
  erb :'merchants/index'
end

get '/merchants/:id' do
  @merchant = Merchant.find_by_id(params['id'])
  erb :'merchants/show'
end
