require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match %r(
 <td[^>]*>1<\/td>\s*
 <td>&times;<\/td>\s*
 <td[^>]*>\s*Programming\sRuby\s1.9\s*</td>
 )x, mail.body.encoded
  end

end
