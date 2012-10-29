module CartHelper
  # CartLine object used to store the productID and quantity
  class CartLine
    attr_accessor :productID, :quantity
  end
  
  # Cart object used to store the CartLine objects in an Array
  class Cart
    attr_reader :cartlines
    
    def initialize
      @cartlines = []
    end
    
    # Add a product and the specified quantity to the CartLine Array.
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
    
    # Remove the specified product from the CartLine Array.
    def remove_line(product)
      i = @cartlines.index { |o| o.productID == product.productID }
      @cartlines.delete_at(i) if i != nil
    end
    
    # Get the total amount from the CartLine Array.
    def compute_total_value
      sum = 0.0
      @cartlines.each do |o|
        product = Product.find(o.productID)
        sum += product.price * o.quantity
      end
      sum
    end
    
    # Get the total quantity from the CartLine Array.
    def total_quantity
      @cartlines.inject(0) { |total, o| total += o.quantity }
    end
    
    # Clear the CartLine Array.
    def clear
      @cartlines.clear
    end
    
    # Get the Cart object from the session. It creates a new Cart object if the session doesn't has any Cart object.
    def self.cart(session)
      cart = session[:cart]
      if cart == nil
        cart = Cart.new
        session[:cart] = cart
      end
      cart
    end
  end
  
  # Shipping Details object for mail order
  class ShippingDetails
    include ActiveModel::Validations
    include ActionView::Helpers::TagHelper
    
    attr_accessor :name, :line1, :line2, :line3, :city, :state, :zip, :country, :giftwrap, :email
    
    validates_presence_of :name, :message => 'shinfo.blank.name'
    validates_presence_of :line1, :message => 'shinfo.blank.line1'
    validates_presence_of :city, :message => 'shinfo.blank.city'
    validates_presence_of :state, :message => 'shinfo.blank.state'
    validates_presence_of :country, :message => 'shinfo.blank.country'
    validates :email, :length => { :within => 5..50, :message => 'shinfo.blank.email' },
                      :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i, :message => 'shinfo.invalid.email' }
                      
    # Submit the order with the Cart details
    def submit_order?(cart)
      if valid?
        mail = Order.send_order(cart, self)
        mail.deliver
        return true
      end
      false
    end
    
    # Show validation error message
    def show_error(key)
      if errors.has_key?(key)
        m = ''
        err = errors[key].first
        if key == :email and err == 'shinfo.blank.email'
          m = I18n.t(err, :value => 5)
          
        else
          m = I18n.t(err)
        end
        content_tag(:span, m, :class => 'form_error')
      end
    end
  end
  
end
