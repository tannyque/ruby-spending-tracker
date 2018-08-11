require 'sinatra'

require_relative '../models/transaction'

get '/transactions/:id' do
  @transaction = Transaction.find_by_id(params['id'])
  erb :'transactions/show'
end
