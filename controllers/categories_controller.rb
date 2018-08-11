require 'sinatra'
require_relative '../models/category'

get '/categories' do
  @categories = Category.all
  erb :'categories/index'
end

get '/categories/:id' do
  @category = Category.find_by_id(params['id'])
  erb :'categories/show'
end
