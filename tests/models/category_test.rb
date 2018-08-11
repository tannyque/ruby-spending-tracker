require_relative '../test_helper'
require_relative '../../models/category'

class CategoryTest < MiniTest::Test
  def setup
    @category1 = Category.new('name' => 'travel')
  end

  def test_category_has_name
    assert_equal('travel', @category1.name)
  end

  def test_unsaved_category_has_nil_id
    assert_nil(@category1.id)
  end
end
