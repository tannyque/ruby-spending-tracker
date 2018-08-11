require_relative '../test_helper'
require_relative '../../models/merchant'

class MerchantTest < MiniTest::Test
  def setup
    @merchant1 = Merchant.new('name' => 'Costa Coffee')
  end

  def test_merchant_has_name
    assert_equal('Costa Coffee', @merchant1.name)
  end

  def test_unsaved_merchant_has_nil_id
    assert_nil(@merchant1.id)
  end
end
