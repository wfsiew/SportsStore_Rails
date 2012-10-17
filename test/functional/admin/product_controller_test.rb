require 'test_helper'

class Admin::ProductControllerTest < ActionController::TestCase
  setup do
    @product = product(:one)
  end
  
  test "should get index" do
    login_as :ben
    get :index
    assert_response :success
    assert_template 'productsadminpage'
    assert_not_nil assigns(:products)
  end
  
  test "should get new" do
    login_as :ben
    get :new
    assert_response :success
    assert_template 'addproductpage'
    assert_not_nil assigns(:product)
  end
  
  test "should create product" do
    login_as :ben
    assert_difference('Product.count') do
      post :create, { :product => { :category => @product.category, :description => @product.description, :name => @product.name, 
                      :price => @product.price, :productID => @product.productID } }
    end
    
    assert_response :redirect
    assert_redirected_to admin_product_path(assigns(:products))
    assert_equal "#{@product.name} has been saved", flash[:notice]
  end
  
  test "should get edit" do
    login_as :ben
    get :edit, { :id => @product.productID }
    assert_response :success
    assert_template 'editproductpage'
    assert_not_nil assigns(:product)
  end
  
  test "should update product" do
    login_as :ben
    put :update, { :id => @product.productID, 
                   :product => { :category => @product.category, :description => @product.description, 
                                 :name => @product.name, :price => @product.price, :productID => @product.productID } }
    assert_response :redirect
    assert_redirected_to admin_product_path(assigns(:products))
    assert_equal "#{@product.name} has been saved", flash[:notice]
  end
  
  test "should destroy product" do
    login_as :ben
    assert_difference('Product.count', -1) do
      delete :destroy, { :id => @product.productID }
    end
    
    assert_response :redirect
    assert_redirected_to admin_product_path
    assert_equal "#{@product.name} was deleted", flash[:notice]
  end
  
end
