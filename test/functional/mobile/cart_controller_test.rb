require 'test_helper'

class Mobile::CartControllerTest < ActionController::TestCase
  setup do
    @product = product(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'cartpage'
    assert_not_nil assigns(:cart)
  end
  
  test "should get add" do
    get :add, { :id => @product.productID }
    assert_response :success
    assert_template 'cartpage'
    assert_not_nil assigns(:cart)
    assert_not_nil session[:cart]
  end
  
  test "should get remove" do
    get :remove, { :id => @product.productID }
    assert_response :success
    assert_template 'cartpage'
    assert_not_nil assigns(:cart)
    assert_equal 0, session[:cart].cartlines.length
  end
  
  test "should post checkout" do
    post :checkout, { :name => 'ben', :email => 'ben@gmail.com', :line1 => 'block 8', :line2 => 'jalan maju', :line3 => 'taman maju',
         :city => 'K.L', :state => 'W.P', :zip => '56000', :country => 'malaysia', :giftwrap => '1' }
    o = assigns(:shippingdetails)
    assert o.submit_order?(session[:cart])
    assert_equal 0, session[:cart].cartlines.length
    assert_template 'checkoutcomplete'
  end
  
  test "should not post checkout without required fields" do
    post :checkout, { :name => '', :email => '', :line1 => '', :line2 => '', :line3 => '',
         :city => '', :state => '', :zip => '', :country => '', :giftwrap => '' }
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
    post :checkout, { :name => '', :email => '', :line1 => '', :line2 => '', :line3 => '',
         :city => '', :state => '', :zip => '', :country => '', :giftwrap => '' }
    assert_not_nil assigns(:cartempty)
    assert_equal "Sorry, your cart is empty!", assigns(:cartempty)
  end
  
end
