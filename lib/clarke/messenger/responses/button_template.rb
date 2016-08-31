module Clarke
  module Messenger
    module Responses
      class ButtonTemplate < Messenger::Responses::Base
        def initialize (recipient, text, buttons, options = {})
          super(recipient)
          @text = text || ""
          @buttons = buttons || []
        end

        def get_request_body
          request_body = request_body_initializer()
          request_body[:message] = {
            attachment: {
              type: "template",
              payload: {
                template_type: "button",
                text: @text,
                buttons: formated_buttons()
              }
            }
          }
          request_body.to_json
        end

        private
        def formated_buttons
          @buttons.map do |button|
            if button[:url]
              formated_url_button(button)
            elsif button[:action]
              formated_payload_button(button)
            elsif button[:phone_number]
              formated_call_button(button)
            end
          end
        end

        def formated_url_button (button)
          {
            type:   'web_url',
            url:    button[:url],
            title:  button[:label]
          }
        end

        def formated_payload_button (button)
          {
            type:     'postback',
            title:    button[:label],
            payload:  button[:action]
          }
        end

        def formated_call_button (button)
          {
            type:     'phone_number',
            title:    button[:label],
            payload:  button[:phone_number]
          }
        end
      end
    end
  end
end
