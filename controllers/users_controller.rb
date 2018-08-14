require 'sinatra'

require_relative '../models/user'

get '/users/:id' do
  @user = User.find_by_id(params['id'])
  @transactions = @user.transactions_by_date.slice(0..9)
  erb :'users/home'
end


get '/users/:id/alert/:transaction_id' do
  p params
  @user = User.find_by_id(params['id'])
  @transaction = Transaction.find_by_id(params['transaction_id'])
  erb :'users/alert'
end
