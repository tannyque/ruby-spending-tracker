require 'sinatra'
require_relative '../models/category'

get '/categories' do
  @categories = Category.all
  erb :'categories/index'
end

get '/categories/new' do
  erb :'categories/new'
end

post '/categories/new' do
  Category.new(params).save
  redirect '/categories'
end

get '/categories/:id' do
  @category = Category.find_by_id(params['id'])
  erb :'categories/show'
end

get '/categories/:id/edit' do
  @category = Category.find_by_id(params['id'])
  erb :'categories/edit'
end

post '/categories/:id/delete' do
  category = Category.find_by_id(params['id'])
  category.delete
  redirect '/categories'
end

post '/categories/:id/update' do
  category = Category.new(params)
  category.update
  redirect "/categories/#{category.id}"
end
