require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @product1 = product(:one)
    @product2 = product(:two)
    @shippingdetails = { :name => 'ruby', :email => 'ruby@gmail.com', :line1 => 'Block 6-8-6', :line2 => 'Kuchai Entrepreneurs Park', 
                         :line3 => 'Jalan Kuchai Lama', :city => 'Kuala Lumpur', :state => 'W.P', :zip => '58200', :country => 'Malaysia' }
  end
  
  test "browse products" do
    get product_path
    assert_response :success
    
    get category_path, :category => @product1.category
    assert_response :success
  end
  
  test "browse products, add to cart, and checkout" do
    get product_path
    assert_response :success
    assert_template 'productspage'
    
    post_via_redirect cart_add_path, :id => @product1.productID
    
    assert_response :success
    assert_equal product_path, path
    assert_not_nil session[:cart]
    
    post cart_add_path, :id => @product2.productID
    
    assert_response :redirect
    assert_redirected_to product_path
    
    follow_redirect!
    
    assert_response :success
    assert_not_nil session[:cart]
    
    assert_equal 2, session[:cart].cartlines.length
    
    get cart_path
    assert_response :success
    assert_template 'cartpage'
    
    get cart_checkout_path
    assert_response :success
    assert_template 'checkoutpage'
    
    post cart_checkout_path, @shippingdetails
    
    assert_response :success
    assert_template 'checkoutcomplete'
    
    assert_equal [], session[:cart].cartlines
  end

end
