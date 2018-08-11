require 'pry-byebug'

require_relative 'models/category'
require_relative 'models/merchant'
require_relative 'models/tag'
require_relative 'models/user'

categories = Category.all
merchants = Merchant.all
tags = Tag.all
users = User.all

binding.pry
nil
