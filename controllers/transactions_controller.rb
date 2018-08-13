require 'sinatra'
require 'pry-byebug'
require_relative '../models/transaction'
require_relative '../models/merchant'
require_relative '../models/category'
require_relative '../models/tag'

get '/transactions/:id' do
  @transaction = Transaction.find_by_id(params['id'])
  @tags = Tag.by_transaction(params['id'])
  erb :'transactions/show'
end

get '/transactions/:user_id/month' do
  @user = User.find_by_id(params['user_id'])
  @month = params['month']
  @transactions = @user.transactions_by_month(@month)
  erb :'transactions/index'
end

get '/transactions/:user_id/category' do
  @user = User.find_by_id(params['user_id'])
  @category = params['category']
  @transactions = @user.transactions_by_category(params['category'])
  erb :'transactions/index'
end

get '/transactions/all/:user_id' do
  @user = User.find_by_id(params['user_id'])
  @transactions = @user.transactions
  erb :'transactions/index'
end

get '/transactions/new/:user_id' do
  @user = User.find_by_id(params['user_id'])
  @merchants = Merchant.all
  @categories = Category.all
  erb :'transactions/new'
end

post '/transactions/new/:user_id' do
  transaction = Transaction.new(params)
  transaction.created_at = Time.now.strftime('%Y-%m-%d %H:%M:%S')
  transaction.save
  Tag.build_from_array(params['tags'], transaction) if params['tags']

  if transaction.user.balance <= 100
    redirect "/users/#{transaction.user.id}/alert/#{transaction.id}"
  else
    redirect "/transactions/#{transaction.id}"
  end
end

get '/transactions/edit/:id' do
  @merchants = Merchant.all
  @categories = Category.all
  @transaction = Transaction.find_by_id(params['id'])
  erb :'transactions/edit'
end

post '/transactions/edit/:id' do
  transaction = Transaction.new(params)
  transaction.user_id = Transaction.find_by_id(params['id']).user_id
  transaction.created_at = Time.now.strftime('%Y-%m-%d %H:%M:%S')
  transaction.update
  transaction.delete_all_tags
  Tag.build_from_array(params['tags'], transaction) if params['tags']

  redirect "/transactions/#{transaction.id}"
end

post '/transactions/:id/delete' do
  transaction = Transaction.find_by_id(params['id'])
  transaction.delete
  redirect "/transactions/all/#{transaction.user.id}"
end
