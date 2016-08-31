module Clarke
  module Messenger
    module Parser
      class << self

        def parse_request (request_body)
          incoming_messages = request_body.dig("entry", 0, "messaging")
          received_messages = []
          return unless incoming_messages
          received_messages = incoming_messages.map{|incoming_message| parse_message(incoming_message)}.compact
          return received_messages
        end

        private
        def parse_message(incoming_message)
          timestamp = incoming_message.dig('timestamp')
          sender_id = incoming_message.dig('sender', 'id')
          message = incoming_message.dig('message')
          message_id = incoming_message.dig('message', 'mid')
          payload = incoming_message.dig('postback', 'payload')
          if message&.dig('text')
            return message_plain_text_formater(message_id, sender_id, timestamp, message.dig('text'))
          elsif message&.dig('attachments')
            #TODO : Handle more than one attachement
            return message_with_attachments_formater(message_id, sender_id, timestamp, message.dig('attachments').first)
          elsif payload
            return message_postback_formater(message_id, sender_id, timestamp, payload)
          else
            return
          end
        end

        def message_plain_text_formater(message_id, sender_id, timestamp, text)
          Clarke::Messenger::Events::TextMessage.new(message_id, sender_id, timestamp, text)
        end

        def message_with_attachments_formater(message_id, sender_id, timestamp, attachment)
          Clarke::Messenger::Events::Media.new(message_id, sender_id, timestamp, attachment.dig('type'), attachment.dig('payload'))
        end

        def message_postback_formater(message_id, sender_id, timestamp, payload)
          Clarke::Messenger::Events::Button.new(message_id, sender_id, timestamp, payload)
        end
      end

    end
  end
end
