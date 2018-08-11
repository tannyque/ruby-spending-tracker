require 'sinatra'
require 'sinatra/contrib/all'

require_relative 'models/user'

also_reload('models/*')

get '/' do
  @users = User.all
  erb :home
end
