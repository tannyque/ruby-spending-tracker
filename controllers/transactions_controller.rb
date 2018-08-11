require 'sinatra'

require_relative '../models/transaction'
require_relative '../models/merchant'
require_relative '../models/category'
require_relative '../models/tag'

get '/transactions/:id' do
  @transaction = Transaction.find_by_id(params['id'])
  @tags = Tag.by_transaction(params['id'])
  erb :'transactions/show'
end

get '/transactions/new/:user_id' do
  @user = User.find_by_id(params['user_id'])
  @merchants = Merchant.all
  @categories = Category.all
  erb :'transactions/new'
end

post '/transactions/new/:user_id' do
  Transaction.new(params).save
  redirect "/users/#{params['user_id']}"
end
