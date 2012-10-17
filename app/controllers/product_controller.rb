# Controller class for the Product Catalog page
class ProductController < ApplicationController
  layout 'productmain'
  
  def index
    dic = get_products
    @cart = CartHelper::Cart.cart(session)
    @categories = dic[:categories]
    @products = dic[:products]
    @pager = dic[:pager]
    @category = dic[:category]
    session[:returnUrl] = request_path
    
    respond_to do |fmt|
      fmt.html { render 'productspage' }
      fmt.json { render :json => dic }
    end
  end
  
  def index_paged
    page = get_page
    dic = get_products("", page)
    @cart = CartHelper::Cart.cart(session)
    @categories = dic[:categories]
    @products = dic[:products]
    @pager = dic[:pager]
    @category = dic[:category]
    session[:returnUrl] = request_path
    
    respond_to do |fmt|
      fmt.html { render 'productspage' }
      fmt.json { render :json => dic }
    end
  end
  
  def category
    dic = get_products(params[:category], 1)
    @cart = CartHelper::Cart.cart(session)
    @categories = dic[:categories]
    @products = dic[:products]
    @pager = dic[:pager]
    @category = dic[:category]
    session[:returnUrl] = request_path
    
    respond_to do |fmt|
      fmt.html { render 'productspage' }
      fmt.json { render :json => dic }
    end
  end
  
  def category_paged
    page = get_page
    dic = get_products(params[:category], page)
    @cart = CartHelper::Cart.cart(session)
    @categories = dic[:categories]
    @products = dic[:products]
    @pager = dic[:pager]
    @category = dic[:category]
    session[:returnUrl] = request_path
    
    respond_to do |fmt|
      fmt.html { render 'productspage' }
      fmt.json { render :json => dic }
    end
  end
  
  def getimage
    product = ProductHelper.get_product(params[:id])
    send_data(product.imagedata, { :type => product.imagemimetype, :disposition => 'inline' })
  end
  
  private
  
  def get_products(category="", pagenum=1)
    categories = ProductHelper.get_categories
    if category.blank?
      dic = ProductHelper.get_all(pagenum, ApplicationHelper::Pager.default_page_size)
      
    else
      dic = ProductHelper.get_by_category(category, pagenum, ApplicationHelper::Pager.default_page_size)
    end
    
    products = dic[:list]
    pager = dic[:pager]
    { :categories => categories, :products => products, :pager => pager, :category => category }
  end
  
  def get_page
    if params[:page].present?
      return params[:page].to_i
    end
    
    return 1
  end
  
end
