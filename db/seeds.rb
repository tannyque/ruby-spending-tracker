require_relative '../models/user'
require_relative '../models/category'
require_relative '../models/merchant'

require 'rake'

sh 'rake db:build'

User.new('name' => 'Catherine').save
User.new('name' => 'Dave').save

Category.new('name' => 'Travel').save
Category.new('name' => 'Shopping').save
Category.new('name' => 'Entertainment').save
Category.new('name' => 'Bills').save
Category.new('name' => 'Food').save

Merchant.new('name' => 'Costa').save
Merchant.new('name' => 'Scotrail').save
Merchant.new('name' => 'British Gas').save
Merchant.new('name' => 'Tesco').save
Merchant.new('name' => 'Odeon Cinemas').save
