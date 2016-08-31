require "./test/test_helper"

class TestClarkeMessengerParser < Test::Unit::TestCase

  test "parse plain text message event" do
    plain_text_request = {
      "entry" => [
        "messaging" => [{
          "sender" => { "id" => "USER_ID" },
          "recipient" => { "id" => "PAGE_ID" },
          "timestamp" => 1458692752478,
          "message" => {
            "mid" => "mid.1457764197618:41d102a3e1ae206a38",
            "seq" => 73,
            "text" => "hello, world!",
            "quick_reply" =>  { "payload" =>  "DEVELOPER_DEFINED_PAYLOAD" }
          }
        }]
      ]
    }
    events = Clarke::Messenger::Parser.parse_request(plain_text_request)
    assert_not_empty events
    message = events.first
    assert message.is_a? Clarke::Messenger::Events::TextMessage
    assert_equal("mid.1457764197618:41d102a3e1ae206a38", message.id)
    assert_equal("USER_ID", message.sender)
    assert_equal(1458692752478, message.timestamp)
    assert_equal("hello, world!", message.text)
  end

  test "parse attachments event" do
    attachments_request = {
      "entry" => [
        "messaging" => [{
          "sender" => { "id" => "USER_ID" },
          "recipient" => { "id" => "PAGE_ID" },
          "timestamp" => 1458692752478,
          "message" => {
            "mid" => "mid.1457764197618:41d102a3e1ae206a38",
            "seq" => 73,
            "attachments" => [{ "type" => "image", "payload" => { "url" => "IMAGE_URL" } }]
          }
        }]
      ]
    }
    events = Clarke::Messenger::Parser.parse_request(attachments_request)
    assert_not_empty events
    message = events.first
    assert message.is_a? Clarke::Messenger::Events::Media
    assert_equal("mid.1457764197618:41d102a3e1ae206a38", message.id)
    assert_equal("USER_ID", message.sender)
    assert_equal(1458692752478, message.timestamp)
    assert_equal("image", message.type)
    assert_equal({"url" => "IMAGE_URL" }, message.media)
  end

  test "parse location attachement event" do
    attachments_request = {
      "entry" => [
        "messaging" => [{
          "sender" => { "id" => "USER_ID" },
          "recipient" => { "id" => "PAGE_ID" },
          "timestamp" => 1458692752478,
          "message" => {
            "mid" => "mid.1457764197618:41d102a3e1ae206a38",
            "seq" => 73,
            "attachments" => [{
              "type" => "location",
              "payload" => {
                "coordinates" => { "lat" => 24, "long" => 42 }
              }
            }]
          }
        }]
      ]
    }
    events = Clarke::Messenger::Parser.parse_request(attachments_request)
    assert_not_empty events
    message = events.first
    assert message.is_a? Clarke::Messenger::Events::Media
    assert_equal("mid.1457764197618:41d102a3e1ae206a38", message.id)
    assert_equal("USER_ID", message.sender)
    assert_equal(1458692752478, message.timestamp)
    assert_equal("location", message.type)
    assert_equal({"coordinates" => { "lat" => 24, "long" => 42 }}, message.media)
  end

  test "parse postback event" do
    postback_request = {
      "entry" => [
        "messaging" => [{
          "sender" => { "id" => "USER_ID" },
          "recipient" => { "id" => "PAGE_ID" },
          "timestamp" => 1458692752478,
          "postback" => { "payload" => "USER_DEFINED_PAYLOAD" }
        }]
      ]
    }
    events = Clarke::Messenger::Parser.parse_request(postback_request)
    assert_not_empty events
    postback = events.first
    assert postback.is_a? Clarke::Messenger::Events::Button
    assert_nil postback.id
    assert_equal("USER_ID", postback.sender)
    assert_equal(1458692752478, postback.timestamp)
    assert_equal("USER_DEFINED_PAYLOAD", postback.action)
  end

end
