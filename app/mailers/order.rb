class Order < ActionMailer::Base
  default from: "admin@localhost"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order.send_order.subject
  #
  def send_order(cart, shippingdetails)
    @cart = cart
    @shippingdetails = shippingdetails

    mail :to => "ben@localhost"
  end
end
