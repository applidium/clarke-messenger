module Clarke
  module Messenger
    module ResponseConverter
      class << self

        def convert (response)
          if response.options[:elements]
            response_to_generic_template(response)
          elsif response.options[:quick_replies]
            response_to_quick_replies_template(response)
          elsif response.buttons.any?
            response_to_button_template(response)
          elsif response.image
            response_to_attachment(response, 'image', response.image)
          elsif response.audio
            response_to_attachment(response, 'audio', response.audio)
          elsif response.video
            response_to_attachment(response, 'video', response.video)
          elsif response.file
            response_to_attachment(response, 'file', response.file)
          elsif response.text
            response_to_text_message(response)
          end
        end

        private
        def has_attachment (response)
          response.image ||
          response.audio ||
          response.video ||
          response.file
        end

        def response_to_generic_template (response)
          Responses::GenericTemplate.new(response.recipient, response.options[:elements], response.options)
        end

        def response_to_quick_replies_template (response)
          Responses::QuickRepliesTemplate.new(response.recipient, response.text, response.options[:quick_replies], response.options)
        end

        def response_to_button_template (response)
          Responses::ButtonTemplate.new(response.recipient, response.text, response.buttons, response.options)
        end

        def response_to_attachment (response, type, media)
          Responses::Attachment.new(response.recipient, type, media[:url], response.options)
        end

        def response_to_text_message (response)
          Responses::TextMessage.new(response.recipient, response.text, response.options)
        end

      end
    end
  end
end
