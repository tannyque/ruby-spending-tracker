require_relative '../test_helper'
require_relative '../../models/transaction'
require_relative '../../models/user'
require_relative '../../models/merchant'

class TransactionTest < MiniTest::Test
  def setup
    @user = User.new('name' => 'Robert')
    @merchant1 = Merchant.new(
      'name' => 'Costa Coffee'
    )
    @transaction1 = Transaction.new(
      'amount' => 100,
      'user_id' => @user.id,
      'merchant_id' => @merchant1.id
    )
  end

  def test_transaction_has_amount
    assert_equal(100, @transaction1.amount)
  end
end
