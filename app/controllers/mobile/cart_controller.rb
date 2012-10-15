class Mobile::CartController < Mobile::MobileController
  layout 'mobileproductcontent'
  
  def index
    @cart = CartHelper::Cart.cart(session)
    @returnUrl = get_return_url
    
    respond_cartpage(@cart)
  end
  
  def add
    product = ProductHelper.get_product(params[:id])
    if product.present?
      CartHelper::Cart.cart(session).add_item(product, 1)
    end
    
    @cart = CartHelper::Cart.cart(session)
    @returnUrl = get_return_url
    
    respond_cartpage(@cart)
  end
  
  def remove
    product = ProductHelper.get_product(params[:id])
    if product.present?
      CartHelper::Cart.cart(session).remove_line(product)
    end
    
    @cart = CartHelper::Cart.cart(session)
    @returnUrl = get_return_url
    
    respond_cartpage(@cart)
  end
  
  def checkout
    @shippingdetails = CartHelper::ShippingDetails.new
    
    if request.post?
      cart = CartHelper::Cart.cart(session)
      if cart.cartlines.blank?
        @cartempty = t('cart.empty')
      end
      
      @shippingdetails.name = params[:name]
      @shippingdetails.email = params[:email]
      @shippingdetails.line1 = params[:line1]
      @shippingdetails.line2 = params[:line2]
      @shippingdetails.line3 = params[:line3]
      @shippingdetails.city = params[:city]
      @shippingdetails.state = params[:state]
      @shippingdetails.zip = params[:zip]
      @shippingdetails.country = params[:country]
      @shippingdetails.giftwrap = params[:giftwrap] == '1' ? true : false
      
      if @shippingdetails.submit_order?(cart)
        cart.clear
        
        respond_to do |fmt|
          fmt.html { render 'checkoutcomplete' }
        end
        
      else
        respond_to do |fmt|
          fmt.html { render 'checkoutpage' }
          fmt.json { render :json => @shippingdetails.errors, status: :unprocessable_entity }
        end
      end
      
    else
      respond_to do |fmt|
        fmt.html { render 'checkoutpage' }
        fmt.json { render :json => @shippingdetails }
      end
    end
  end
  
  private
  
  def respond_cartpage(o)
    respond_to do |fmt|
      fmt.html { render 'cartpage' }
      fmt.json { render :json => o}
    end
  end
  
  def get_return_url
    session[:returnUrl].blank? ? mobile_product_path : session[:returnUrl]
  end
  
end
