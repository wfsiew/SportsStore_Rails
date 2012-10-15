class Mobile::ProductController < Mobile::MobileController
  layout 'mobileproductcontent', :except => [:index]
  layout false, :only => [:index]
  
  def index
    @categories = ProductHelper.get_categories
    @cart = CartHelper::Cart.cart(session)
    
    respond_to do |fmt|
      fmt.html { render 'productspage' }
      fmt.json { render :json => [@cart, @categories] }
    end
  end
  
  def index_paged
    page = get_page
    dic = get_products("", page)
    @products = dic[:products]
    @returnUrl = dic[:returnUrl]
    
    respond_productsummary(dic)
  end
  
  def category
    dic = get_products(params[:category], 1)
    @products = dic[:products]
    @category = dic[:category]
    @returnUrl = dic[:returnUrl]
    
    respond_productsummary(dic)
  end
  
  def category_paged
    page = get_page
    dic = get_products(params[:category], page)
    @products = dic[:products]
    @category = dic[:category]
    @returnUrl = dic[:returnUrl]
    
    respond_productsummary(dic)
  end
  
  def list_paged
    @category = params[:category]
    @returnUrl = params[:returnUrl]
    if category.blank?
      dic = ProductHelper.get_all(pagenum, 10)
      
    else
      dic = ProductHelper.get_by_category(@category, pagenum, 10)
    end
    
    @products = dic[:list]
    
    respond_to do |fmt|
      fmt.html { render 'productsummarylist' }
      fmt.json { render :json => dic }
    end
  end
  
  private
  
  def get_products(category="", pagenum=1)
    if category.blank?
      dic = ProductHelper.get_all(pagenum, 10)
      
    else
      dic = ProductHelper.get_by_category(category, pagenum, 10)
    end
    
    products = dic[:list]
    session[:returnUrl] = request_path
    { :products => products, :returnUrl => session[:returnUrl], :category => category }
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
  
end
