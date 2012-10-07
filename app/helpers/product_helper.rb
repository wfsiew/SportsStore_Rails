module ProductHelper
  
  def self.get_all(pagenum, pagesize)
    total = Product.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    products = Product.limit(pager.pagesize).offset(pager.lower_bound)
    { :pager => pager, :list => products }
  end
  
  def self.get_by_category(category, pagenum, pagesize)
    products = Product.find_all_by_category(category)
    total = products.length
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    products = Product.find_all_by_category(category, :limit => pager.pagesize, :offset => pager.lower_bound)
    { :pager => pager, :list => products }
  end
  
  def self.get_categories
    Product.all(:select => 'distinct category', :order => 'category')
  end
  
  def self.get_product(productID)
    Product.find_by_productID(productID)
  end
  
  def self.get_uploaded_file(file)
    content_type = file.content_type
    data = file.read
    return content_type, data
  end
  
  class CartLine
    attr_accessor :product, :quantity
  end
  
  class Cart
    attr_reader :cartlines
    
    def initialize
      @cartlines = []
    end
    
    def add_item(product, quantity)
      i = @cartlines.index { |o| o.product.productID == product.productID }
      if i == nil
        o = CartLine.new
        o.product = product
        o.quantity = quantity
        @cartlines.push(o)
        
      else
        @cartlines[i].quantity += quantity
      end
    end
    
    def remove_line(product)
      i = @cartlines.index { |o| o.product.productID == product.productID }
      @cartlines.delete_at(i) if i != nil
    end
    
    def compute_total_value
      sum = 0.0
      @cartlines.each { |o| sum += o.product.price * o.quantity }
      sum
    end
    
    def total_quantity
      total = 0
      @cartlines.each { |o| total += o.quantity }
      total
    end
    
    def clear
      @cartlines.clear
    end
    
    def self.cart(session)
      cart = session[:cart]
      if cart == nil
        cart = Cart.new
        session[:cart] = cart
      end
      
      cart
    end
  end
  
end
