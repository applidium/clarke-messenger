module Clarke
  module Messenger
    module ResponseSender
      class << self

        def send_response (generic_response)
          # Convert the generic responses into messenger responses and then send it
          messenger_response = ResponseConverter.convert(generic_response)
          send_messenger_response(messenger_response)
        end

        private

        def send_messenger_response (response)
          request_body = response.get_request_body
          response.http_response = HTTP.headers(content_type: "application/json", accept: "application/json")
            .post(request_endpoint, :body => request_body)
        end

        def request_endpoint
          "#{Config::API_ENDPOINT}?access_token=#{Config.facebook_page_token}"
        end

      end
    end
  end
end
