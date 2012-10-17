require 'test_helper'

class CartControllerTest < ActionController::TestCase
  setup do
    @product = product(:two)
    @shippingdetails = { :name => 'ben', :email => 'ben@gmail.com', :line1 => 'block 8', :line2 => 'jalan maju', :line3 => 'taman maju',
                         :city => 'K.L', :state => 'W.P', :zip => '56000', :country => 'malaysia', :giftwrap => '1' }
    @emptyshippingdetails = { :name => '', :email => '', :line1 => '', :line2 => '', :line3 => '',
                              :city => '', :state => '', :zip => '', :country => '', :giftwrap => '' }
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_template 'cartpage'
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:returnUrl)
  end
  
  test "should post add" do
    post :add, { :id => @product.productID }
    assert_not_nil session[:cart]
    assert_equal 1, session[:cart].cartlines.length
    assert_redirected_to product_path
  end
  
  test "should delete remove" do
    delete :remove, { :id => @product.productID }
    assert_equal 0, session[:cart].cartlines.length
    assert_redirected_to cart_path
  end
  
  test "should get checkout" do
    post :add, { :id => @product.productID }
    get :checkout
    assert_response :success
    assert_template 'checkoutpage'
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:shippingdetails)
  end
  
  test "should post checkout" do
    post :checkout, @shippingdetails
    o = assigns(:shippingdetails)
    assert o.submit_order?(session[:cart])
    assert_equal 0, session[:cart].cartlines.length
    assert_template 'checkoutcomplete'
  end
  
  test "should not post checkout without required fields" do
    post :checkout, @emptyshippingdetails
    o = assigns(:shippingdetails)
    assert !o.valid?
    assert !o.submit_order?(session[:cart])
    assert o.errors[:name].any?
    assert o.errors[:email].any?
    assert o.errors[:line1].any?
    assert o.errors[:city].any?
    assert o.errors[:state].any?
    assert o.errors[:country].any?
    
    assert_equal ['shinfo.blank.name'], o.errors[:name]
    assert_equal ['shinfo.blank.email', 'shinfo.invalid.email'], o.errors[:email]
    assert_equal ['shinfo.blank.line1'], o.errors[:line1]
    assert_equal ['shinfo.blank.city'], o.errors[:city]
    assert_equal ['shinfo.blank.state'], o.errors[:state]
    assert_equal ['shinfo.blank.country'], o.errors[:country]
  end
  
  test "should not post checkout with empty cartlines" do
    post :checkout, @emptyshippingdetails
    assert_not_nil assigns(:cartempty)
    assert_equal "Sorry, your cart is empty!", assigns(:cartempty)
  end
  
end
