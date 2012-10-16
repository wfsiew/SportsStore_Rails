require 'test_helper'

class CartControllerTest < ActionController::TestCase
  setup do
    @product = product(:two)
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
    post :add, :id => @product.productID
    assert_not_nil session[:cart]
    assert_equal 1, session[:cart].cartlines.length
    assert_redirected_to product_path
  end
  
end
