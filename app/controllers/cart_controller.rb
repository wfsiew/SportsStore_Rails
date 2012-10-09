class CartController < ApplicationController
  layout 'productmain'
  
  def index
    @cart = CartHelper::Cart.cart(session)
    @categories = ProductHelper.get_categories
    @returnUrl = (params[:returnUrl] == nil ? '/' : params[:returnUrl])
    
    respond_to do |fmt|
      fmt.html { render 'cartpage' }
    end
  end
  
  def add
    returnUrl = params[:returnUrl]
    product = ProductHelper.get_product(params[:id])
    if product != nil
      CartHelper::Cart.cart(session).add_item(product, 1)
    end
    
    redirect_to returnUrl
  end
  
  def remove
    returnUrl = params[:returnUrl]
    product = ProductHelper.get_product(params[:id])
    if product != nil
      CartHelper::Cart.cart(session).remove_line(product)
    end
    
    redirect_to returnUrl
  end
  
  def checkout
    @cart = CartHelper::Cart.cart(session)
    @categories = ProductHelper.get_categories
    @shippingdetails = CartHelper::ShippingDetails.new
    
    if request.post?
      if @cart.cartlines.blank?
        @cartempty = 'cart.empty'
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
      
      if @shippingdetails.submit_order?
        @cart.clear
        
        respond_to do |fmt|
          fmt.html { render 'checkoutcomplete' }
        end
        
      else
        respond_to do |fmt|
          fmt.html { render 'checkoutpage' }
        end
      end
      
    else
      respond_to do |fmt|
        fmt.html { render 'checkoutpage' }
      end
    end
  end
  
end
