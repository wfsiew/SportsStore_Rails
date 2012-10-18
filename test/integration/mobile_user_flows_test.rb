require 'test_helper'

class MobileUserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @product1 = product(:one)
    @product2 = product(:two)
    @shippingdetails = { :name => 'ruby', :email => 'ruby@gmail.com', :line1 => 'Block 6-8-6', 
                         :line2 => 'Kuchai Entrepreneurs Park', :line3 => 'Jalan Kuchai Lama', :city => 'Kuala Lumpur', 
                         :state => 'W.P', :zip => '58200', :country => 'Malaysia' }
  end
  
  test "browse main page" do
    get mobile_product_path
    assert_response :success
    
    get mobile_category_path, :category => @product1.category
    assert_response :success
    
    post mobile_list_paged_path, :page => 1, :category => @product2.category
    assert_response :success
  end
  
  test "browse products, add to cart, and checkout" do
    get mobile_product_paged_path, :page => 1
    assert_response :success
    assert_template 'productsummary'
    
    get mobile_cart_add_path, :id => @product1.productID
    assert_response :success
    assert_template 'cartpage'
    
    get mobile_cart_add_path, :id => @product2.productID
    assert_response :success
    assert_template 'cartpage'
    
    assert_not_nil session[:cart]
    assert_equal 2, session[:cart].cartlines.length
    
    get mobile_cart_path
    assert_response :success
    assert_template 'cartpage'
    
    get mobile_cart_checkout_path
    assert_response :success
    assert_template 'checkoutpage'
    
    post mobile_cart_checkout_path, @shippingdetails
    
    assert_response :success
    assert_template 'checkoutcomplete'
    
    assert_equal [], session[:cart].cartlines
  end
  
end
