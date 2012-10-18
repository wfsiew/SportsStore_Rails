require 'test_helper'

class OrderTest < ActionMailer::TestCase
  include CartHelper
  
  setup do
    @product = product(:one)
  end
  
  test "send_order" do
    shippingdetails = ShippingDetails.new
    shippingdetails.name = 'ben'
    shippingdetails.email = 'ben@gmail.com'
    shippingdetails.line1 = 'block 8'
    shippingdetails.line2 = 'jalan maju'
    shippingdetails.line3 = 'taman maju'
    shippingdetails.city = 'K.L'
    shippingdetails.state = 'W.P'
    shippingdetails.zip = 56000
    shippingdetails.country = 'malaysia'
    
    cart = Cart.new
    cart.add_item(@product, 9)
    
    mail = Order.send_order(cart, shippingdetails)
    mail.deliver
    
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [shippingdetails.email], mail.to
    assert_equal "New order submitted!", mail.subject
    assert_equal ["admin@localhost"], mail.from
    assert_match /<h3>A new order has been submitted<\/h3>/, mail.body.encoded
    assert_match /#{shippingdetails.name}/, mail.body.encoded
  end

end
