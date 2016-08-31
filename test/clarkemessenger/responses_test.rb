require "./test/test_helper"
require 'json'

class TestClarkeMessengerResponses < Test::Unit::TestCase

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
        label: "Welcome to Peter\'s Hats",
        image: "https://petersfancybrownhats.com/company_image.png",
        url: "https://petersfancybrownhats.com",
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

  test "get correct request body for text message" do
    request_body = Clarke::Messenger::Responses::TextMessage.new(@USER_ID, @text).get_request_body
    waited_request_body = {
      "recipient": @recipient,
      "message":{"text": @text}
    }
    assert_equal(waited_request_body.to_json, request_body)
  end

  test "get correct request body for attachment message" do
    request_body = Clarke::Messenger::Responses::Attachment.new(@USER_ID, @media_type, @media_url).get_request_body
    waited_request_body = {
      "recipient": @recipient,
      "message": {
        "attachment": {
          "type": @media_type,
          "payload":{"url": @media_url}
        }
      }
    }
    assert_equal(waited_request_body.to_json, request_body)
  end

  test "formated_buttons" do
    formated_buttons = Clarke::Messenger::Responses::ButtonTemplate.new(@USER_ID, @text, @buttons).send(:formated_buttons)
    waited_buttons = [
      {
        type: "web_url",
        url: "https://petersapparel.parseapp.com",
        title: "Show Website"
      },
      {
        type: "postback",
        title: "Start Chatting",
        payload: "USER_DEFINED_PAYLOAD"
      },
      {
        type: "phone_number",
        title: "Call Representative",
        payload: "+15105551234"
      }
    ]
    assert_equal(waited_buttons, formated_buttons)
  end

  test "get correct request body for button message" do
    request_body = Clarke::Messenger::Responses::ButtonTemplate.new(@USER_ID, @text, @buttons).get_request_body
    waited_request_body = {
      "recipient": @recipient,
      "message":{
       "attachment": {
         "type": "template",
         "payload": {
           "template_type": "button",
           "text": @text,
           "buttons":[
             {
               "type": "web_url",
               "url": "https://petersapparel.parseapp.com",
               "title": "Show Website"
             },
             {
               "type": "postback",
               "title": "Start Chatting",
               "payload": "USER_DEFINED_PAYLOAD"
             },
             {
               "type": "phone_number",
               "title": "Call Representative",
               "payload": "+15105551234"
             }
           ]
         }
       }
     }
    }
    assert_equal(waited_request_body.to_json, request_body)
  end

  test "formatted_elements" do
    formatted_elements = Clarke::Messenger::Responses::GenericTemplate.new(@USER_ID, @elements).send(:formatted_elements)
    waited_elements = [
      {
        title: "Welcome to Peter\'s Hats",
        item_url: "https://petersfancybrownhats.com",
        image_url: "https://petersfancybrownhats.com/company_image.png",
        buttons: [
          {
            type: "web_url",
            url: "https://petersapparel.parseapp.com",
            title: "Show Website"
          },
          {
            type: "postback",
            title: "Start Chatting",
            payload: "USER_DEFINED_PAYLOAD"
          },
      {
        type: "phone_number",
        title: "Call Representative",
        payload: "+15105551234"
      }
        ]
      }
    ]
    assert_equal(waited_elements, formatted_elements)
  end

  test "formatted_elements - sharable" do
    formatted_elements = Clarke::Messenger::Responses::GenericTemplate.new(@USER_ID, @elements, { can_be_shared: true }).send(:formatted_elements)
    waited_elements = [
      {
        title: "Welcome to Peter\'s Hats",
        item_url: "https://petersfancybrownhats.com",
        image_url: "https://petersfancybrownhats.com/company_image.png",
        buttons: [
          {
            type: "web_url",
            url: "https://petersapparel.parseapp.com",
            title: "Show Website"
          },
          {
            type: "postback",
            title: "Start Chatting",
            payload: "USER_DEFINED_PAYLOAD"
          },
          {
            type: "phone_number",
            title: "Call Representative",
            payload: "+15105551234"
          },
          {
            type: "element_share"
          }
        ]
      }
    ]
    assert_equal(waited_elements, formatted_elements)
  end

  test "get correct request body for generic message" do
    request_body = Clarke::Messenger::Responses::GenericTemplate.new(@USER_ID, @elements).get_request_body
    waited_request_body = {
      "recipient": @recipient,
      "message":{
        "attachment": {
          "type": "template",
          "payload": {
            "template_type": "generic",
            "elements":[
              {
                "title":"Welcome to Peter\'s Hats",
                "item_url": "https://petersfancybrownhats.com",
                "image_url":"https://petersfancybrownhats.com/company_image.png",
                "buttons":[
                  {
                    "type": "web_url",
                    "url": "https://petersapparel.parseapp.com",
                    "title": "Show Website"
                  },
                  {
                    "type": "postback",
                    "title": "Start Chatting",
                    "payload": "USER_DEFINED_PAYLOAD"
                  },
                  {
                    "type": "phone_number",
                    "title": "Call Representative",
                    "payload": "+15105551234"
                  }
                ]
              }
            ]
          }
        }
      }
    }
    assert_equal(waited_request_body.to_json, request_body)
  end

  test "get correct request body for sharable generic message" do
    request_body = Clarke::Messenger::Responses::GenericTemplate.new(@USER_ID, @elements, { can_be_shared: true }).get_request_body
    waited_request_body = {
      "recipient": @recipient,
      "message":{
        "attachment": {
          "type": "template",
          "payload": {
            "template_type": "generic",
            "elements":[
              {
                "title":"Welcome to Peter\'s Hats",
                "item_url": "https://petersfancybrownhats.com",
                "image_url":"https://petersfancybrownhats.com/company_image.png",
                "buttons":[
                  {
                    "type": "web_url",
                    "url": "https://petersapparel.parseapp.com",
                    "title": "Show Website"
                  },
                  {
                    "type": "postback",
                    "title": "Start Chatting",
                    "payload": "USER_DEFINED_PAYLOAD"
                  },
                  {
                    "type": "phone_number",
                    "title": "Call Representative",
                    "payload": "+15105551234"
                  },
                  {
                    "type": "element_share"
                  }
                ]
              }
            ]
          }
        }
      }
    }
    assert_equal(waited_request_body.to_json, request_body)
  end

  test "formatted_quick_replies" do
    formatted_quick_replies = Clarke::Messenger::Responses::QuickRepliesTemplate.new(@USER_ID, @text, @quick_replies).send(:formatted_quick_replies)
    waited_quick_replies = [
      {
        content_type: "text",
        title: "Red",
        payload: "DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
      },
      {
        content_type: "text",
        title: "Green",
        payload: "DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
      }
    ]
    assert_equal(waited_quick_replies, formatted_quick_replies)
  end

  test "get correct request body for quick replies" do
    request_body = Clarke::Messenger::Responses::QuickRepliesTemplate.new(@USER_ID, @text, @quick_replies).get_request_body
    waited_request_body = {
      "recipient": @recipient,
      "message":{
        "text":"where is bryan ?",
        "quick_replies":[
          {
            content_type: "text",
            title: "Red",
            payload: "DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
          },
          {
            content_type: "text",
            title: "Green",
            payload: "DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
          }
        ]
      }
    }
    assert_equal(waited_request_body.to_json, request_body)
  end


end
