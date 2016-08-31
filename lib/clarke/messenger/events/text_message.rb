module Clarke
  module Messenger
    module Events
      class TextMessage < Messenger::Events::Base
        include Clarke::Events::TextMessage
        attr_accessor :text

        def initialize (id, sender_id, timestamp, text)
          super(id, sender_id, timestamp)
          @text = text
        end

      end
    end
  end
end
