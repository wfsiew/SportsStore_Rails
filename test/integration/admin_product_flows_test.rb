require 'test_helper'

class AdminProductFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
    @product = product(:one)
  end

  test "login, create, update, and delete product" do
    ben = admin_user
    ben.logs_in @user.username, 'secret'
    ben.create_product :name => @product.name, :description => @product.description, :price => @product.price,
                       :category => @product.category
    @product.name = 'testing'
    ben.update_product @product, { :name => @product.name, :description => @product.description, :price => @product.price,
                                   :category => @product.category }
    ben.destroy_product @product
    ben.logs_out
  end
  
  private
  
  def admin_user
    open_session do |user|
      def user.logs_in(username, password)
        get admin_login_path
        assert_response :success
        assert_template 'new'
        
        post_via_redirect admin_auth_path, :username => username, :password => password
        
        assert_response :success
        assert_equal admin_product_path, path
        assert_template 'productsadminpage'
        assert_equal "Logged in successfully", flash[:notice]
        assert_not_nil session[:user_id]
      end
      
      def user.logs_out
        get_via_redirect admin_logout_path
    
        assert_response :success
        assert_equal admin_login_path, path
        assert_template 'new'
        assert_equal "You successfully logged out", flash[:notice]
        assert_nil session[:user_id]
      end
      
      def user.create_product(product_hash)
        get admin_product_new_path
        assert_response :success
        assert_template 'addproductpage'
        
        post admin_product_create_path, :product => product_hash
        
        assert assigns(:product).valid?
        assert_response :redirect
        assert_redirected_to admin_product_path(assigns(:products))
        
        follow_redirect!
        
        assert_response :success
        assert_template 'productsadminpage'
        assert_equal "#{product_hash[:name]} has been saved", flash[:notice]
      end
      
      def user.update_product(product, product_hash)
        get admin_product_edit_path, :id => product.productID
        assert_response :success
        assert_template 'editproductpage'
        
        put admin_product_update_path, :id => product.productID, :product => product_hash

        assert assigns(:product).valid?
        assert_response :redirect
        assert_redirected_to admin_product_path(assigns(:products))
        
        follow_redirect!
        
        assert_response :success
        assert_template 'productsadminpage'
        assert_equal "#{product.name} has been saved", flash[:notice]
      end
      
      def user.destroy_product(product)
        delete admin_product_delete_path, :id => product.productID
        
        assert_response :redirect
        assert_redirected_to admin_product_path(assigns(:products))
        
        follow_redirect!
        
        assert_response :success
        assert_template 'productsadminpage'
        assert_equal "#{product.name} was deleted", flash[:notice]
      end
    end
  end
  
end
