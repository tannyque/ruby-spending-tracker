require 'sinatra'
require_relative '../models/merchant'

get '/merchants' do
  @merchants = Merchant.all
  erb :'merchants/index'
end

get '/merchants/new' do
  erb :'merchants/new'
end

post '/merchants/new' do
  Merchant.new(params).save
  redirect '/merchants'
end

get '/merchants/:id' do
  @merchant = Merchant.find_by_id(params['id'])
  erb :'merchants/show'
end

post '/merchants/:id/update' do
  merchant = Merchant.new(params)
  merchant.update
  redirect "/merchants/#{merchant.id}"
end

post '/merchants/:id/delete' do
  merchant = Merchant.find_by_id(params['id'])
  merchant.delete
  redirect '/merchants'
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id(params['id'])
  erb :'merchants/edit'
end
