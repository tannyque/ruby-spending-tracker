require 'sinatra'
require 'sinatra/contrib/all' if development?

require_relative 'models/user'

also_reload('models/*') if development?

get '/' do
  @users = User.all
  erb :home
end
