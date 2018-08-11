require_relative '../models/user'
require_relative '../models/category'
require_relative '../models/merchant'
require_relative '../models/transaction'
require_relative '../models/tag'

require 'pry-byebug'
require 'rake'

Tag.delete_all
Transaction.delete_all
Category.delete_all
User.delete_all
Merchant.delete_all


user1 = User.new('name' => 'Catherine')
user2 = User.new('name' => 'Dave')
user1.save
user2.save

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

merchants = Merchant.all
categories = Category.all

20.times do
  transaction = Transaction.new(
    'amount' => rand(1..100),
    'user_id' => user1.id,
    'merchant_id' => merchants.sample.id
  )
  transaction.save
end

binding.pry
nil
