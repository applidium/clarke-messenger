module Clarke
  module Messenger
    module Responses
      class QuickRepliesTemplate < Messenger::Responses::Base
        def initialize (recipient, text, quick_replies, options = {})
          super(recipient)
          @text = text || ""
          @quick_replies = quick_replies || []
        end

        def get_request_body
          request_body = request_body_initializer()
          request_body[:message] = {
            text: @text,
            quick_replies: formatted_quick_replies()
          }
          request_body.to_json
        end

        private
        def formatted_quick_replies
          @quick_replies.map do |quick_reply|
            {
              content_type: 'text',
              title: quick_reply[:title],
              payload: quick_reply[:action]
            }
          end
        end
      end
    end
  end
end
