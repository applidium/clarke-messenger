require "./test/test_helper"

class TestClarkeMessengerResponseConverter < Test::Unit::TestCase

  setup do
    @USER_ID = 'USER_ID'
    @recipient = {"id": @USER_ID}
    @text = 'where is bryan ?'
    @media_url = 'in://kitchen'
    @media_type = 'file'
    @buttons = [
      {
        label: 'Show Website',
        url: 'https://petersapparel.parseapp.com'
      },
      {
        label: 'Start Chatting',
        action: 'USER_DEFINED_PAYLOAD'
      },
      {
        label: 'Call Representative',
        phone_number: '+15105551234'
      }
    ]
    @elements = [
      {
        title: "Welcome to Peter\'s Hats",
        image: "https://petersfancybrownhats.com/company_image.png",
        buttons: @buttons
      }
    ]
    @quick_replies = [
      {
        title: 'Red',
        action: 'DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED'
      },
      {
        title: 'Green',
        action: 'DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN'
      }
    ]
  end

  test 'convert text message response' do
    clarke_response = Clarke::Response.new(@USER_ID, {text: @text})
    messenger_response = Clarke::Messenger::ResponseConverter.convert(clarke_response)
    assert messenger_response.is_a? Clarke::Messenger::Responses::TextMessage
  end

  test 'convert buttons response' do
    clarke_response = Clarke::Response.new(@USER_ID, {text: @text, buttons: @buttons})
    messenger_response = Clarke::Messenger::ResponseConverter.convert(clarke_response)
    assert messenger_response.is_a? Clarke::Messenger::Responses::ButtonTemplate
  end

  test 'convert quick replies response' do
    clarke_response = Clarke::Response.new(@USER_ID, {text: @text, quick_replies: @quick_replies})
    messenger_response = Clarke::Messenger::ResponseConverter.convert(clarke_response)
    assert messenger_response.is_a? Clarke::Messenger::Responses::QuickRepliesTemplate
  end

  test 'convert generic response' do
    clarke_response = Clarke::Response.new(@USER_ID, {elements: @elements})
    messenger_response = Clarke::Messenger::ResponseConverter.convert(clarke_response)
    assert messenger_response.is_a? Clarke::Messenger::Responses::GenericTemplate
  end

  test 'convert media response' do
    clarke_response = Clarke::Response.new(@USER_ID, {text: @text, image: {url: @media_url}})
    messenger_response = Clarke::Messenger::ResponseConverter.convert(clarke_response)
    assert messenger_response.is_a? Clarke::Messenger::Responses::Attachment
  end
end
