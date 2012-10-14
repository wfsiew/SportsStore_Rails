class Mobile::CartController < Mobile::MobileController
  layout 'mobileproductcontent'
  
  def index
    @cart = CartHelper::Cart.cart(session)
    @returnUrl = get_return_url
    
    respond_to do |fmt|
      fmt.html { render 'cartpage' }
      fmt.json { render :json => @cart }
    end
  end
  
  def add
    product = ProductHelper.get_product(params[:id])
    if product.present?
      CartHelper::Cart.cart(session).add_item(product, 1)
    end
    
    @cart = CartHelper::Cart.cart(session)
    @returnUrl = get_return_url
    
    respond_to do |fmt|
      fmt.html { render 'cartpage' }
      fmt.json { render :json => @cart }
    end
  end
  
  def remove
    product = ProductHelper.get_product(params[:id])
    if product.present?
      CartHelper::Cart.cart(session).remove_line(product)
    end
    
    @cart = CartHelper::Cart.cart(session)
    @returnUrl = get_return_url
    
    respond_to do |fmt|
      fmt.html { render 'cartpage' }
      fmt.json { render :json => @cart }
    end
  end
  
  def checkout
    
  end
  
  private
  
  def get_return_url
    session[:returnUrl].blank? ? mobile_product_path : session[:returnUrl]
  end
  
end
