module Clarke
  module Messenger
    module Responses
      class Attachment < Messenger::Responses::Base
        def initialize (recipient, type, url, options = {})
          super(recipient)
          @type = type
          @url = url
        end

        def get_request_body
          request_body = request_body_initializer()
          request_body[:message] = {
            attachment: {
              type: @type,
              payload: {url: @url}
            }
          }
          request_body.to_json
        end
      end
    end
  end
end
