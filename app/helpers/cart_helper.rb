module CartHelper
  
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
