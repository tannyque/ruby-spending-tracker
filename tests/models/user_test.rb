require_relative '../test_helper'
require_relative '../../models/user'

class UserTest < MiniTest::Test
  def setup
    @user1 = User.new('name' => 'Robert', 'budget' => 1000)
  end

  def test_user_has_name
    assert_equal('robert', @user1.name)
  end

  def test_user_has_budget
    assert_equal(1000, @user1.budget)
  end

  def test_unsaved_user_has_nil_id
    assert_nil(@user1.id)
  end
end
