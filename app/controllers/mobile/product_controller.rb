class Mobile::ProductController < Mobile::MobileController
  layout 'mobileproductcontent', :except => [:index, :list_paged]
  
  def index
    @categories = ProductHelper.get_categories
    @cart = CartHelper::Cart.cart(session)
    session[:returnUrl] = request_path
    
    respond_to do |fmt|
      fmt.html { render 'productspage', :layout => false }
      fmt.json { render :json => [@cart, @categories] }
    end
  end
  
  def index_paged
    page = get_page
    dic = get_products("", page)
    @products = dic[:products]
    @returnUrl = request_path
    session[:returnUrl] = @returnUrl
    
    respond_productsummary(dic)
  end
  
  def category
    dic = get_products(params[:category], 1)
    @products = dic[:products]
    @category = dic[:category]
    @returnUrl = request_path
    session[:returnUrl] = @returnUrl
    
    respond_productsummary(dic)
  end
  
  def category_paged
    page = get_page
    dic = get_products(params[:category], page)
    @products = dic[:products]
    @category = dic[:category]
    @returnUrl = request_path
    session[:returnUrl] = @returnUrl
    
    respond_productsummary(dic)
  end
  
  def list_paged
    page = get_page
    category = params[:category]
    if category.blank?
      dic = ProductHelper.get_all(page, 10)
      
    else
      dic = ProductHelper.get_by_category(category, page, ApplicationHelper::Pager.default_page_size)
    end
    
    @products = dic[:list]
    
    respond_to do |fmt|
      fmt.html { render :partial => 'productsummarylist', :layout => false }
      fmt.json { render :json => @products }
    end
  end
  
  private
  
  def get_products(category="", pagenum=1)
    if category.blank?
      dic = ProductHelper.get_all(pagenum, ApplicationHelper::Pager.default_page_size)
      
    else
      dic = ProductHelper.get_by_category(category, pagenum, ApplicationHelper::Pager.default_page_size)
    end
    
    products = dic[:list]
    session[:returnUrl] = request_path
    { :products => products, :category => category }
  end
  
  def respond_productsummary(o)
    respond_to do |fmt|
      fmt.html { render 'productsummary' }
      fmt.json { render :json => o }
    end
  end
  
  def get_page
    if params[:page].present?
      return params[:page].to_i
    end
    
    return 1
  end
  
  def get_return_url
    session[:returnUrl].blank? ? mobile_product_path : session[:returnUrl]
  end
  
end
