class ProductsController < ApplicationController  
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    
    #@dic = ProductsHelper.get_all(1, 2)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end
  
  # GET /products/1/getimg
  def getimg
    @product = Product.find(params[:id])
    send_data(@product.imagedata, :type => @product.imagemimetype, :disposition => 'inline')
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    product = params[:product]
    c, data = ProductsHelper.get_uploaded_file(product[:imagedata])
    
    o = Product.new(:productID => product[:productID], :name => product[:name], :description => product[:description],
    :price => product[:price], :category => product[:category], :imagedata => data, :imagemimetype => c)
    @product = o

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
