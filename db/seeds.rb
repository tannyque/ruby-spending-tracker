require_relative '../models/user'
require_relative '../models/category'
require 'rake'

sh 'rake db:build'

User.new('name' => 'Catherine').save
User.new('name' => 'Dave').save

Category.new('name' => 'travel').save
Category.new('name' => 'shopping').save
Category.new('name' => 'entertainment').save
Category.new('name' => 'bills').save
Category.new('name' => 'food').save
