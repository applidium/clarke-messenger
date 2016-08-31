require "./test/test_helper"

class TestClarkeMessengerEvents < Test::Unit::TestCase

  test "should include modules" do
    message = Clarke::Messenger::Events::TextMessage.new(nil, nil, nil, nil)
    assert message.class.include?(Clarke::Events::TextMessage)
  end

  test "should not raise errors" do
    message = Clarke::Messenger::Events::TextMessage.new(:id, :sender_id, :ts, :text)
    assert_nothing_raised do
      message.sender
    end
  end
end
