class CartController < ApplicationController
  layout 'productmain'
  
  def index
    @cart = CartHelper::Cart.cart(session)
    @categories = ProductHelper.get_categories
    @returnUrl = get_return_url
    
    respond_to do |fmt|
      fmt.html { render 'cartpage' }
      fmt.json { render :json => @cart }
    end
  end
  
  def add
    returnUrl = get_return_url
    product = ProductHelper.get_product(params[:id])
    if product.present?
      CartHelper::Cart.cart(session).add_item(product, 1)
    end
    
    redirect_to returnUrl
  end
  
  def remove
    product = ProductHelper.get_product(params[:id])
    if product.present?
      CartHelper::Cart.cart(session).remove_line(product)
    end
    
    redirect_to cart_path
  end
  
  def checkout
    @cart = CartHelper::Cart.cart(session)
    @categories = ProductHelper.get_categories
    @shippingdetails = CartHelper::ShippingDetails.new
    
    if request.post?
      if @cart.cartlines.blank?
        @cartempty = t('cart.empty')
      end
      
      @shippingdetails.name = params[:name]
      @shippingdetails.line1 = params[:line1]
      @shippingdetails.line2 = params[:line2]
      @shippingdetails.line3 = params[:line3]
      @shippingdetails.city = params[:city]
      @shippingdetails.state = params[:state]
      @shippingdetails.zip = params[:zip]
      @shippingdetails.country = params[:country]
      @shippingdetails.giftwrap = params[:giftwrap] == '1' ? true : false
      
      if @shippingdetails.submit_order?(@cart)
        @cart.clear
        
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
        fmt.json { render :json => @cart }
      end
    end
  end
  
  private
  
  def get_return_url
    session[:returnUrl].blank? ? product_path : session[:returnUrl]
  end
  
end
