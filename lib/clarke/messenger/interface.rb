module Clarke
  module Messenger
    class << self
      def parse (request)
        # Parse the incomming request and return a generic message
        Parser.parse_request(request)
      end

      def deliver (responses)
        # Convert the generic responses into messenger responses and then send it
        responses.each {|response| ResponseSender.send_response(response) }
      end
    end
  end
end
