class Admin::ProductController < ApplicationController
  
  def index
    @products = Product.all
    
    respond_to do |fmt|
      fmt.html { render 'productsadminpage', :layout => 'productadmin' }
      fmt.json { render :json => @products }
    end
  end
  
  def new
    @product = Product.new
    
    respond_to do |fmt|
      fmt.html { render 'addproductpage', :layout => 'productform' }
      fmt.json { render :json => @product } 
    end
  end
  
  def create
    q = params[:product]
    imagemimetype, imagedata = ProductHelper.get_uploaded_file(q[:imagedata])
        
    o = Product.new(:name => q[:name], :description => q[:description], :price => q[:price],
        :category => q[:category], :imagedata => imagedata, :imagemimetype => imagemimetype)
    @product = o
    
    respond_to do |fmt|
      if @product.save
        fmt.html { redirect_to admin_product_url, :notice => t('product.save_success', :value => @product.name) }
        fmt.json { render :json => @product, :status => :created, :location => @product }
          
      else
        fmt.html { render 'addproductpage', :layout => 'productform' }
        fmt.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @product = Product.find(params[:id])
      
    respond_to do |fmt|
      fmt.html { render 'editproductpage', :layout => 'productform' }
      fmt.json { render :json => @product }
    end
  end
  
  def update
    @product = Product.find(params[:id])
    q = params[:product]
    dic = { :name => q[:name], :description => q[:description], :price => q[:price],
      :category => q[:category] }
      
    if q[:imagedata].present?
      imagemimetype, imagedata = ProductHelper.get_uploaded_file(q[:imagedata])
      dic[:imagedata] = imagedata
      dic[:imagemimetype] = imagemimetype
    end
    
    respond_to do |fmt|
      if @product.update_attributes(dic)
        fmt.html { redirect_to admin_product_url, :notice => t('product.save_success', :value => @product.name) }
        fmt.json { head :no_content }
          
      else
        fmt.html { render 'editproductpage', :layout => 'productform' }
        fmt.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    
    respond_to do |fmt|
      fmt.html { redirect_to admin_product_url, :notice => t('product.delete_success', :value => product.name) }
      fmt.json { head :no_content }
    end
  end
  
end
