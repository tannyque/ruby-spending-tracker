require_relative '../models/user'
require_relative '../models/category'
require_relative '../models/merchant'
require_relative '../models/transaction'
require_relative '../models/tag'

require 'pry-byebug'

Tag.delete_all
Transaction.delete_all
Category.delete_all
User.delete_all
Merchant.delete_all

user1 = User.new('name' => 'Catherine', 'budget' => 3000)
user2 = User.new('name' => 'Dave', 'budget' => 2000)
user1.save
user2.save

Category.new('name' => 'Travel').save
Category.new('name' => 'Shopping').save
Category.new('name' => 'Entertainment').save
Category.new('name' => 'Bills').save
Category.new('name' => 'Food').save

Merchant.new('name' => 'Costa').save
Merchant.new('name' => 'ScotRail').save
Merchant.new('name' => 'British Gas').save
Merchant.new('name' => 'Tesco').save
Merchant.new('name' => 'Odeon Cinemas').save

merchants = Merchant.all
categories = Category.all

# Generate a Time object representing a random time in the previous year.
def random_time
  end_date = Date.today
  start_date = end_date - 365
  Time.at((end_date.to_time.to_f - start_date.to_time.to_f) * rand + start_date.to_time.to_f)
end

20.times do
  transaction = Transaction.new(
    'amount' => rand(1..100),
    'user_id' => user1.id,
    'merchant_id' => merchants.sample.id,
    'created_at' => random_time.strftime('%Y-%m-%d %H:%M:%S')
  )
  transaction.save
end

transactions = Transaction.all

40.times do
  tag = Tag.new(
    'category_id' => categories.sample.id,
    'transaction_id' => transactions.sample.id
  )
  tag.save
end

binding.pry
nil
