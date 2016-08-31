module Clarke
  module Messenger
    module Responses
      class Base

        def initialize (recipient)
          @recipient_id = recipient
        end

        def get_request_body
          raise NotImplementedError, 'get_request_body'
        end

        protected
        def request_body_initializer
          {
            recipient: {
              id: @recipient_id
            }
          }
        end
      end
    end
  end
end
