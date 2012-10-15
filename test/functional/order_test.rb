require 'test_helper'

class OrderTest < ActionMailer::TestCase
  test "send_order" do
    mail = Order.send_order
    assert_equal "Send order", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end