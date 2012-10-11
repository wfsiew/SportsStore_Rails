module CartHelper
  
  class CartLine
    attr_accessor :productID, :quantity
  end
  
  class Cart
    attr_reader :cartlines
    
    def initialize
      @cartlines = []
    end
    
    def add_item(product, quantity)
      i = @cartlines.index { |o| o.productID == product.productID }
      if i == nil
        o = CartLine.new
        o.productID = product.productID
        o.quantity = quantity
        @cartlines.push(o)
        
      else
        @cartlines[i].quantity += quantity
      end
    end
    
    def remove_line(product)
      i = @cartlines.index { |o| o.productID == product.productID }
      @cartlines.delete_at(i) if i != nil
    end
    
    def compute_total_value
      sum = 0.0
      @cartlines.each do |o|
        product = ProductHelper.get_product(o.productID)
        sum += product.price * o.quantity
      end
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
  
  class ShippingDetails
    include ActiveModel::Validations
    include ActionView::Helpers::TagHelper
    
    attr_accessor :name, :line1, :line2, :line3, :city, :state, :zip, :country, :giftwrap
    
    validates_presence_of :name, :message => 'shinfo.blank.name'
    validates_presence_of :line1, :message => 'shinfo.blank.line1'
    validates_presence_of :city, :message => 'shinfo.blank.city'
    validates_presence_of :state, :message => 'shinfo.blank.state'
    validates_presence_of :country, :message => 'shinfo.blank.country'
    
    def submit_order?
      if valid?
        return true
      end
      
      false
    end
    
    def show_error(key)
      if errors.has_key?(key)
        content_tag(:span, I18n.t(errors.get(key).first), :class => 'form_error')
      end
    end
  end
  
end
