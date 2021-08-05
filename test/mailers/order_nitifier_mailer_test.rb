require "test_helper"

class OrderNitifierMailerTest < ActionMailer::TestCase
  test "recevied" do
    mail = OrderNitifierMailer.recevied
    assert_equal "Recevied", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNitifierMailer.shipped
    assert_equal "Shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
