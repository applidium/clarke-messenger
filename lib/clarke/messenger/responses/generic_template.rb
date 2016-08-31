module Clarke
  module Messenger
    module Responses
      class GenericTemplate < Messenger::Responses::Base
        def initialize (recipient, elements, options = {})
          super(recipient)
          @elements = elements || []
          @can_be_shared = options[:can_be_shared]
        end

        def get_request_body
          request_body = request_body_initializer()
          request_body[:message] = {
            attachment: {
              type: "template",
              payload: {
                template_type: "generic",
                elements: formatted_elements()
              }
            }
          }
          request_body.to_json
        end

        private
        def formatted_elements
          @elements.map do |element|
            {
              title: element[:label],
              item_url: element[:url] || '',
              image_url: element[:image] || '',
              buttons: formatted_buttons(element[:buttons])
            }
          end
        end

        def formatted_buttons(buttons)
          all_formatted_buttons = formatted_element_buttons(buttons)
          all_formatted_buttons << formatted_share_button if @can_be_shared
          all_formatted_buttons
        end

        def formatted_element_buttons(buttons)
          return [] unless buttons
          buttons.map do |button|
            if button[:url]
              formatted_url_button(button)
            elsif button[:action]
              formatted_payload_button(button)
            elsif button[:phone_number]
              formatted_call_button(button)
            end
          end
        end

        def formatted_url_button(button)
          {
            type:   'web_url',
            url:    button[:url],
            title:  button[:label]
          }
        end

        def formatted_payload_button(button)
          {
            type:     'postback',
            title:    button[:label],
            payload:  button[:action]
          }
        end

        def formatted_call_button(button)
          {
            type:     'phone_number',
            title:    button[:label],
            payload:  button[:phone_number]
          }
        end

        def formatted_share_button
          {
            type: 'element_share'
          }
        end
      end
    end
  end
end
