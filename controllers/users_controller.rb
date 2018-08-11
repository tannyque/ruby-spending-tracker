require 'sinatra'

require_relative '../models/user'

get '/users/:id' do
  @user = User.find_by_id(params['id'])
  @transactions = @user.transactions
  erb :'users/home'
end
