module Clarke
  module Messenger
    module Responses
      class TextMessage < Messenger::Responses::Base
        def initialize (recipient, text, options = {})
          super(recipient)
          @text = text
        end

        def get_request_body
          request_body = request_body_initializer()
          request_body[:message] = {text: @text}
          request_body.to_json
        end
      end
    end
  end
end
