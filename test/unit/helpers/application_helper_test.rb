require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper
  
  test "Pager at first page" do
    pager = Pager.new(22, 1, 10)
    assert_equal 10, pager.pagesize
    assert_equal "1 to 10 of 22", pager.item_message
    assert_equal 0, pager.lower_bound
    assert_equal 10, pager.upper_bound
    assert pager.has_next?
    assert_equal false, pager.has_prev?
    assert_equal 3, pager.total_pages
  end
  
  test "Pager at last page" do
    pager = Pager.new(22, 3, 10)
    assert_equal 10, pager.pagesize
    assert_equal "21 to 22 of 22", pager.item_message
    assert_equal 20, pager.lower_bound
    assert_equal 22, pager.upper_bound
    assert_equal false, pager.has_next?
    assert pager.has_prev?
    assert_equal 3, pager.total_pages
  end
  
  test "Pager with many records" do
    pager = Pager.new(150, 3, 10)
    assert_equal 10, pager.pagesize
    assert_equal "21 to 30 of 150", pager.item_message
    assert_equal 20, pager.lower_bound
    assert_equal 30, pager.upper_bound
    assert pager.has_next?
    assert pager.has_prev?
    assert_equal 15, pager.total_pages
  end
  
  test "Pager with total records less than pagesize" do
    pager = Pager.new(20, 1, 100)
    assert_equal 20, pager.pagesize
    assert_equal "1 to 20 of 20", pager.item_message
    assert_equal 0, pager.lower_bound
    assert_equal 20, pager.upper_bound
    assert_equal false, pager.has_next?
    assert_equal false, pager.has_prev?
    assert_equal 1, pager.total_pages
  end
  
  test "Utils.item_message" do
    s = Utils.item_message(22, 1, 10)
    assert_equal "1 to 10 of 22", s
    s = Utils.item_message(22, 3, 10)
    assert_equal "21 to 22 of 22", s
    s = Utils.item_message(150, 3, 10)
    assert_equal "21 to 30 of 150", s
    s = Utils.item_message(20, 1, 100)
    assert_equal "1 to 20 of 20", s
  end
  
  test "Utils.numeric?" do
    assert !Utils.numeric?('yu')
    assert Utils.numeric?('-89')
    assert Utils.numeric?('906.88')
  end
  
end
