require "./test/test_helper"

class TestClarkeMessengerResponseSender < Test::Unit::TestCase

  setup do
  end

  test 'correct request_endpoint' do
    Clarke::Messenger::Config.facebook_page_token = 'AZERTY'
    request_endpoint = Clarke::Messenger::ResponseSender.send(:request_endpoint)
    waited_request_endpoint = "https://graph.facebook.com/v2.6/me/messages?access_token=AZERTY"
    assert_equal(waited_request_endpoint, request_endpoint)
  end
end
