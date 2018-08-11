require_relative '../test_helper'
require_relative '../../models/user'

class UserTest < MiniTest::Test
  def setup
    @user1 = User.new('name' => 'Robert')
  end

  def test_user_has_name
    assert_equal('Robert', @user1.name)
  end

  def test_unsaved_user_has_nil_id
    assert_nil(@user1.id)
  end
end
