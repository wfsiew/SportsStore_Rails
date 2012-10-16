require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
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
  end
end