require 'test_helper'

class ProductHelperTest < ActionView::TestCase
  include ProductHelper
  
  setup do
    @product1 = product(:one)
    @product2 = product(:two)
  end
  
  test "ProductHelper.get_all" do
    m = ProductHelper.get_all(1, 10)
    pager = m[:pager]
    list = m[:list]
    assert_not_nil pager
    assert_not_nil list
    assert_equal 2, pager.total
    assert_equal 2, list.length
    assert_equal 1, list[0].productID
    assert_equal 2, list[1].productID
  end
  
  test "ProductHelper.get_by_category" do
    m = ProductHelper.get_by_category('Soccer', 1, 5)
    pager = m[:pager]
    list = m[:list]
    assert_not_nil pager
    assert_not_nil list
    assert_equal 1, pager.total
    assert_equal 1, list.length
    assert_equal 1, list[0].productID
    
    m = ProductHelper.get_by_category('test', 1, 5)
    pager = m[:pager]
    list = m[:list]
    assert_not_nil pager
    assert_not_nil list
    assert_equal 0, pager.total
    assert_equal [], list
  end
  
  test "ProductHelper.get_categories" do
    a = ProductHelper.get_categories
    assert_not_nil a
    assert_equal 2, a.length
  end
  
  test "ProductHelper.get_product" do
    a = ProductHelper.get_product(2)
    assert_not_nil a
    
    a = ProductHelper.get_product(8)
    assert_nil a
  end
  
end
