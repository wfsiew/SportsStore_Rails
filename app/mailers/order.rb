class Order < ActionMailer::Base
  default :from => "admin@localhost"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order.send_order.subject
  #
  
  # Send the order with the Cart and ShippingDetails
  def send_order(cart, shippingdetails)
    @cart = cart
    @shippingdetails = shippingdetails

    mail :to => shippingdetails.email, :subject => t('order.subject')
  end
end
