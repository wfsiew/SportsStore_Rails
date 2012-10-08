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
    
    if request.method == 'POST'
      @shippingdetails.save
      puts @shippingdetails.inspect
    end
    
    respond_to do |fmt|
      fmt.html { render 'checkoutpage' }
    end
  end
  
end
